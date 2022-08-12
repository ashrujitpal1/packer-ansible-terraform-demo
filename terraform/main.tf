resource "aws_instance" "ec2" {
  ami           = "${data.aws_ami.packer_image.id}"
  instance_type = "${var.vm_size}"
  subnet_id = "${aws_subnet.subnet[0].id}"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  key_name = "codedeploy"
  tags = {
    Name = "${var.stack}-growlerfriday"
  }
}

data "aws_ami" "packer_image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["example-ami-packer"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["465327730173"] # Canonical
}
