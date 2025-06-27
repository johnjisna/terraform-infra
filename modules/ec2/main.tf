resource "aws_launch_template" "public" {
  name_prefix   = "lt-public-"
  image_id      = var.image_id
  instance_type = var.instance_type

 vpc_security_group_ids = [var.ec2_public_sg_id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    apt update -y
    apt install -y nginx
    systemctl start nginx
    systemctl enable nginx
    echo "<h1>Hello from PUBLIC EC2</h1>" > /usr/share/nginx/html/index.html
  EOF
  )
}

resource "aws_launch_template" "private" {
  name_prefix   = "lt-private-"
  image_id      = var.image_id
  instance_type = var.instance_type

vpc_security_group_ids = [var.ec2_private_sg_id]

  user_data = base64encode(<<-EOF
  #!/bin/bash
  exec > /var/log/user-data.log 2>&1
  set -xe

  apt update -y
  apt install -y nginx

  systemctl enable nginx
  systemctl start nginx

  mkdir -p /usr/share/nginx/html/api
  echo "API works!" > /usr/share/nginx/html/api/index.html
EOF
)

}

resource "aws_autoscaling_group" "public" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = var.public_subnet_ids
  target_group_arns    = var.target_group_arns_public

  launch_template {
    id      = aws_launch_template.public.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg-public"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "private" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = var.private_subnet_ids
  target_group_arns    = var.target_group_arns_private

  launch_template {
    id      = aws_launch_template.private.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg-private"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scale_out_public" {
  name                   = "scale-out-public"
  autoscaling_group_name = aws_autoscaling_group.public.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}

resource "aws_autoscaling_policy" "scale_out_private" {
  name                   = "scale-out-private"
  autoscaling_group_name = aws_autoscaling_group.private.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}
