# AWS基本設定
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "ap-northeast-1"
}

resource "aws_key_pair" "deployer" {
  key_name_prefix = "${var.prefix}-"
  public_key      = "${file("${var.ssh_public_key_path}")}"
}

resource "aws_instance" "sandbox" {
  ami           = "ami-0ff21806645c5e492"
  instance_type = "t2.micro"

  tags = {
    Name = "sandbox-01"
  }

  vpc_security_group_ids = [
    "${var.security_group_id}",
  ]

  disable_api_termination = true

  key_name = "${aws_key_pair.deployer.key_name}"

  connection {
    user        = "ec2-user"
    private_key = "${file(var.ssh_private_key_path)}"
  }

  lifecycle {
    ignore_changes = [
      "tag",
    ]
  }
}

output "public_ip" {
  value = "${aws_instance.sandbox.0.public_ip}"
}
