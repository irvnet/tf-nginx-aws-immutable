
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
    private_key = file("${path.module}/keys/demo-1")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo service nginx start"
    ]
  }

  tags = {
      Name      = "webserver-01"
      proj      = "webserver"
      terraform = true
      env       = "test"
  }


}
