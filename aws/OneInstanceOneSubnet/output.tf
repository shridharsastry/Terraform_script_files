/*
output "server_public_ip" {
    for_each = toset(var.vm_names)
    value = aws_instance.web-server-instance[each.key].public_ip

}

output "server_id" {
    for_each = toset(var.vm_names)
    value = aws_instance.web-server-instance[each.key].id
}
*/