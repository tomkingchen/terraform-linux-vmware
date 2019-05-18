provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}


data "vsphere_datacenter" "dc" {
  name = "${var.data_center}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.data_store}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "${var.resource_pool}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vds_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template"{
    name          = "${var.template_name}"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm" {
  name             = "${var.vm_name}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 2
  memory   = 1024
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"
  
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"


    customize {
      linux_options{
        host_name = "${var.vm_name}"
        domain = "contoso.local"
      }


      network_interface {
        ipv4_address = "${var.vm_ipaddress}"
        ipv4_netmask = "24"
      }

      ipv4_gateway = "10.1.1.1"
      dns_server_list = ["10.1.1.10"]
    }
  }

  provisioner "remote-exec"{
    
    connection {
        type     = "ssh"
        timeout  = "10m"
        user     = "vm_user"
        private_key = "${file("${var.privatekey_file}")}"
      }
    
    inline = [
        "sudo apt-get upgrade -y",
        "sudo -S apt-get install iperf3 -y"
    ]
  }

}
