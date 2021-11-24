
resource "aws_instance" "websrv-01" {
  ami           = var.AMI_ID
  instance_type = "t2.micro"

  root_block_device {
     volume_size = 20
   }

  # the VPC subnet
  subnet_id = aws_subnet.main-public-01.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = "deployer-key"

  connection {
    type = "ssh"
    user = "ubuntu"
    host = self.public_ip
    private_key = file("keys/demo-1")
  }

 provisioner "file" {
    source      = "../config/index.html"
    destination = "/tmp/index.html"
  }

 provisioner "file" {
    source      = "../scripts/markup-home-page.sh"
    destination = "/tmp/markup-home-page.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/markup-home-page.sh",
      "sudo /tmp/markup-home-page.sh"
    ]
  }

  tags = {
      Name      = "webserver-01"
      proj      = "webserver"
      terraform = true
      env       = "test"
  }


}
