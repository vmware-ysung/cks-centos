provider "google" {
	credentials = file(var.gcp_credentials)
	project	= var.gcp_project
	region = var.gcp_region
	zone = var.gcp_zone
}

data "google_compute_image" "kubeadm_gce_image" {
  family  = "centos-8"
  project   = "centos-cloud"
}

resource "google_compute_network" "cks_network" {
	name = "cks-vpc"
	auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "cks_subnet" {
	name = "cks-subnetwork"
	ip_cidr_range = var.subnet_cidr
	network = google_compute_network.cks_network.name
}

resource "google_compute_firewall" "cks_allow_internal" {
	name = "cks-allow-internal"
	network = google_compute_network.cks_network.name
	allow {
	  protocol = "tcp"
	}
    allow {
	  protocol = "udp"
	}
	allow {
	  protocol = "icmp"
	}
	source_ranges = [var.subnet_cidr,var.k8s_pod_cidr]
}

resource "google_compute_firewall" "cks_allow_external" {
	name = "cks-allow-external"
	network = google_compute_network.cks_network.name
	allow {
	  protocol = "icmp"
	}
	allow {
	  protocol = "tcp"
	  ports = [22,6443]
	}
	source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "cks-master" {
  name		= "cks-master1"
  machine_type	= var.instance_type
  metadata	= {
    ssh-keys = "ysung: ${file("~/.ssh/id_rsa.pub")}"
  }
  boot_disk {
    auto_delete		= true
    initialize_params {
      size	= 200
      image	= data.google_compute_image.kubeadm_gce_image.self_link
    }
  }
  network_interface {
    subnetwork	= google_compute_subnetwork.cks_subnet.self_link
    network_ip	= cidrhost(var.subnet_cidr, 11)
    access_config {
    }
  }
  can_ip_forward	= true
  tags		= ["kubernetes", "k8s", "controller"]
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
}

resource "google_compute_instance" "cks-workers" {
  count		= var.worker_count
  name		= "cks-worker${count.index+1}"
  machine_type	= var.instance_type
  metadata	= {
    ssh-keys = "ysung: ${file("~/.ssh/id_rsa.pub")}"
    pod-cidr	= cidrsubnet(var.k8s_pod_cidr,16,count.index+1)
  }
  boot_disk {
    auto_delete		= true
    initialize_params {
      size	= 200
      image	= data.google_compute_image.kubeadm_gce_image.self_link
    }
  }
  network_interface {
    subnetwork	= google_compute_subnetwork.cks_subnet.self_link
    network_ip	= cidrhost(var.subnet_cidr,count.index+21)
    access_config {
    }
  }
  can_ip_forward	= true
  tags		= ["kubernetes", "k8s", "worker"]
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  
}

resource "local_file" "ansible_host" {
 content = templatefile("templates/hosts.tpl",
	   {
		 cks_master = google_compute_instance.cks-master.*.network_interface.0.access_config.0.nat_ip
		 cks_worker = google_compute_instance.cks-workers.*.network_interface.0.access_config.0.nat_ip
	   }
	)
 filename = "${path.module}/hosts"
}

resource "local_file" "kubeadm_config" {
  content = templatefile("templates/kubeadm-config.tpl",
    {
      k8s_version = var.k8s_version
      k8s_pod_cidr = var.k8s_pod_cidr
      k8s_service_dns = var.k8s_service_cidr
    }
  )
  filename = "${path.module}/kubeadm/kubeadm.config"
}

resource "local_file" "cloud_config" {
  content = templatefile("templates/cloud-config.tpl",
    {
      gcp_project = var.gcp_project
    }
  )
  filename = "${path.module}/kubeadm/cloud-config"
}

resource "null_resource" "ansible_playbook_centos" {
  depends_on = [
	local_file.ansible_host,
  ]
  provisioner "local-exec" {
    command = "ansible-playbook centos/main.yaml"
  }
}

resource "null_resource" "ansible_playbook_kubeadm" {
  depends_on = [
  null_resource.ansible_playbook_centos,
  ]
  provisioner "local-exec" {
    command = "ansible-playbook kubeadm/main.yaml"
  }
}


