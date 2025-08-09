resource "sakuracloud_server" "controller_node" {
  count = 1
  name  = "controller-${count.index}"
  disks = [ sakuracloud_disk.controller[count.index].id ]
  core = 4
  memory = 4

  network_interface {
    upstream = "shared"
  }
  disk_edit_parameter {
    hostname        = "controller-${count.index}"
    password        = "passwordpassword"
    disable_pw_auth = true

    ssh_keys = [trimspace(file("~/.ssh/id_ed25519.pub")),trimspace(file("../ansible.pub"))] 
  }
}

resource "sakuracloud_disk" "controller" {
  count             = 1
  name              = "controller-${count.index}"
  source_archive_id = data.sakuracloud_archive.ubuntu.id
  lifecycle {
    ignore_changes = [source_archive_id]
  }
}