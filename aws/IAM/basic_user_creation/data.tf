data "local_file" "pgp_key" {
  filename = "./public-key-base64-encoded.gpg"
}