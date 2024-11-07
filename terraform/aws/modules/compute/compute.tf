resource "aws_security_group" "sg_public" {
    name   = "sg_public"
    vpc_id = var.vpc10_id
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["10.0.0.0/16", "20.0.0.0/16"]
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

data "template_file" "user_data" {
  template = file("./modules/compute/scripts/userdata.sh")
}

resource "aws_instance" "ec2_public" {
    ami                    = var.ec2_ami
    instance_type          = "t2.micro"
    subnet_id              = var.sn_vpc10_pub.id
    vpc_security_group_ids = [aws_security_group.sg_public.id]
    key_name               = "vockey"
}

resource "aws_instance" "ec2_public_2" {
    ami                    = var.ec2_ami
    instance_type          = "t2.micro"
    subnet_id              = var.sn_vpc10_pub2.id
    vpc_security_group_ids = [aws_security_group.sg_public.id]
    key_name               = "vockey"
}


resource "aws_security_group" "sg_private" {
    name   = "sg_private"
    vpc_id = var.vpc20_id
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["20.0.0.0/16", "10.0.0.0/16"]
    }
}

resource "aws_instance" "ec2_private" {
    ami                    = "ami-0f409bae3775dc8e5"
    instance_type          = "t2.micro"
    subnet_id              = var.sn_vpc20_priv.id
    vpc_security_group_ids = [aws_security_group.sg_private.id]
    key_name               = "vockey"
}


## Target Group

resource "aws_lb_target_group" "ec2_lb_tg" {
    name     = "ec2-lb-tg"
    protocol = "HTTP"
    port     = "80"
    vpc_id   = aws_vpc.vpc10.id
}

resource "aws_lb_target_group_attachment" "ec2_lb_tg-ec2_public" {
    target_group_arn = aws_lb_target_group.ec2_lb_tg.arn
    target_id        = aws_instance.ec2_public.id
    port             = 80
}

resource "aws_lb_target_group_attachment" "ec2_lb_tg-ec2_public_2" {
    target_group_arn = aws_lb_target_group.ec2_lb_tg.arn
    target_id        = aws_instance.ec2_public_2.id
    port             = 80
}

# RESOURCE: LOAD BALANCER
resource "aws_lb" "ec2_lb" {
    name               = "ec2-lb"
    load_balancer_type = "application"
    subnets            = [sn_vpc10_pub.id, sn_vpc10_pub2.id]
    security_groups    = [aws_security_group.sg_public.id]
}

resource "aws_lb_listener" "ec2_lb_listener" {
    protocol          = "HTTP"
    port              = "80"
    load_balancer_arn = aws_lb.ec2_lb.arn
    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.ec2_lb_tg.arn
    }
}