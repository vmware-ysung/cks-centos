variable "gcp_project" {
	type = string
	default = "vmware-ysung"
}

variable "gcp_region" {
  type    = string
  default = "us-central1"
}

variable "gcp_zone" {
  type    = string
  default = "us-central1-c"
}

variable "gcp_credentials" {
	type = string
	default = "~/.ssh/vmware-ysung.json"
}

variable "instance_type" {
  type = string
  default = "n2-standard-2"
}

variable "my_ip" {
  type = string
  default ="104.185.159.235/32"
}

variable "ssh_user" {
  type = string
  default = "ysung"
}

variable "ssh_pub" {
  type = string
  default = "~/.ssh/id_rsa.pub"
}

variable "worker_count" {
  type          = number
  default       = 3
}

variable "k8s_version" {
  type		= string
  default	= "1.19.4"
}

variable "k8s_cloud_dns_zone" {
  type = string
  default = "ysung-public"
}

variable "k8s_service_dns" {
  type = string
  default = "phartdoctor.us"
}

variable "subnet_cidr" {
  type          = string
  default       = "10.240.0.0/24"
}

variable "k8s_pod_cidr" {
  type          = string
  default       = "10.200.0.0/16"
}

variable "k8s_service_cidr" {
  type		= string
  default	= "10.96.0.0/12"
}
