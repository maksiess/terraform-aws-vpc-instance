resource "null_resource"  "commands" {
    depends_on = ["aws_instance.Apache"]
    triggers = {
        always_run = "${timestamp()}"
    }
    provisioner "remote-exec" {
        connection {
        host = "${aws_instance.Apache.public_ip}"
        type = "ssh"
        user = "centos"
        private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
        "sudo yum install httpd -y",
        "sudo yum install epel-release -y",
        "sudo yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm",
        "sudo yum-config-manager --enable remi-php74",
        "sudo yum install php -y",
        "sudo systemctl restart httpd",
        "sudo systemctl enable httpd",
        "sudo yum install wget -y",
        "sudo wget https://wordpress.org/latest.tar.gz",
        "sudo tar -xf latest.tar.gz -C /var/www/html/",
        "sudo mv /var/www/html/wordpress/* /var/www/html/",
        "sudo yum install php-mysql -y",
        "sudo systemctl restart httpd",
        "sudo getenforce",
        "sudo sed ‘s/SELINUX=permissive/SELINUX=enforcing/g’ /etc/sysconfig/selinux -i",
        "sudo setenforce 0",
        "sudo chown -R apache:apache /var/www/html/",
        "sudo systemctl restart httpd",
        ]
    }
}
resource "null_resource"  "commands1" {
    depends_on = ["aws_instance.DB"]
    triggers = {
        always_run = "${timestamp()}"
    }
    provisioner "remote-exec" {
        connection {
        host = "${aws_instance.DB.public_ip}"
        type = "ssh"
        user = "centos"
        private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
        "sudo yum install httpd -y",
        "sudo systemctl start httpd",
        "sudo systemctl enable httpd",
        ]
    }
}