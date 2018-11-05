provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.region}"
}

resource "aws_instance" "api" {
  ami = "ami-0f65671a86f061fcd"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.aws_sg.name}"]
  key_name = "${aws_key_pair.aws_key.id}"

  tags {
   Name = "api-instance"
  }
}

resource "aws_instance" "web" {
  ami = "ami-0f65671a86f061fcd"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.aws_sg.name}"]
  key_name = "${aws_key_pair.aws_key.id}"

  tags {
   Name = "web-instance"
  }
}

resource "aws_key_pair" "aws_key" {
  key_name = "${var.key_name}"
  public_key = "${file("${var.key_path}")}"
}

resource "aws_security_group" "aws_sg" {
  name        = "aws_sg"
  description = "Used in the terraform for TEST"

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

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_route53_record" "web" {
  zone_id = "${var.zone_id}"
  name = "${element(var.domains, count.index)}.devops.srwx.net"
  type = "A"
  ttl = "300"
  records = ["${aws_instance.web.public_ip}"]
}
