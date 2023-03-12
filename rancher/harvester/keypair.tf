resource "tls_private_key" "global_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Temporary key pair used for SSH accesss
resource "harvester_ssh_key" "vm_ssh_key" {
  name       = "${var.prefix}-vm-ssh-key"
  public_key = trimspace(tls_private_key.global_key.public_key_openssh)
}

resource "local_sensitive_file" "ssh_private_key_pem" {
  filename        = format("%s/%s", var.generated_files_dir, "id_rsa")
  content         = tls_private_key.global_key.private_key_pem
  file_permission = "0600"
}

resource "local_file" "ssh_public_key_openssh" {
  filename = format("%s/%s", var.generated_files_dir, "id_rsa.pub")
  content  = tls_private_key.global_key.public_key_openssh
}
