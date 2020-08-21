resource "aws_instance" "Apache" {

  ami           = "ami-027362d8f67f505f9"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  key_name      = "${aws_key_pair.bastion.key_name}"
  vpc_security_group_ids = ["${aws_security_group.wordpress-sg.id}"]
  availability_zone = "us-east-1a"
  subnet_id       = "${aws_subnet.public1.id}"
  source_dest_check = false
  tags      =   "${var.tags}"

}

resource "aws_instance" "DB" {
  ami           = "ami-027362d8f67f505f9"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  key_name      = "${aws_key_pair.bastion.key_name}"
  vpc_security_group_ids = ["${aws_security_group.mysql-sg.id}"]
  availability_zone = "us-east-1b"
  subnet_id       = "${aws_subnet.public2.id}"
  source_dest_check = false

  tags      =   "${var.tags}"

}
