resource "sakuracloud_server" "worker_node" {
  count = 3
  name  = "worker-${count.index}"
  disks = [ sakuracloud_disk.worker[count.index].id]
  core = 4
  memory = 4

  network_interface {
    upstream = "shared"
  }
  disk_edit_parameter {
    hostname        = "worker-${count.index}"
    password        = "passwordpassword"
    disable_pw_auth = true

    ssh_keys = [trimspace(file("~/.ssh/id_ed25519.pub")),trimspace(file("../ansible.pub"))] 
  }
}


resource "sakuracloud_disk" "worker" {
  count             = 3
  name              = "worker-${count.index}"
  source_archive_id = data.sakuracloud_archive.ubuntu.id
  lifecycle {
    ignore_changes = [ source_archive_id ]
  }
}