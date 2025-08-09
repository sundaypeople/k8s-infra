locals {
  controller = {for server in sakuracloud_server.controller_node : server.name => {"ansible_host" = server.ip_address}}
  worker = {for server in sakuracloud_server.worker_node : server.name => {"ansible_host" = server.ip_address}}
}

resource "local_file" "create_inventory" {
  depends_on = [ sakuracloud_server.controller_node,sakuracloud_server.worker_node ]
  content = templatefile("${path.module}/templates/inventory.yml.tftpl",{controller=local.controller,worker=local.worker})
  filename = "../kubespray/inventory/default/inventory.yml"
}