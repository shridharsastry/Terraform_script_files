data "local_file" "pgp_key" {
  filename = var.gpg_location
}
