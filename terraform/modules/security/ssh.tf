resource "tls_private_key" "ssh_private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "ssh_private_key_file" {
  content  = tls_private_key.ssh_private_key.private_key_pem
  filename = "ssh/${var.tags["project_name"]}"
}

resource "local_file" "ssh_public_key_file" {
  content  = tls_private_key.ssh_private_key.public_key_openssh
  filename = "ssh/${var.tags["project_name"]}.pub"
}

resource "aws_key_pair" "this" {
  public_key = tls_private_key.ssh_private_key.public_key_openssh

  tags = merge({ name = "OCP-SSH-Key" }, var.tags)
}
