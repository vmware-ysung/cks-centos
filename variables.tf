variable "gcp_project" {
	type = string
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
}

variable "instance_type" {
  type = string
  default = "n2-standard-2"
}

variable "my_ip" {
  type = string
}

variable "ssh_user" {
  type = string
}

variable "ssh_pub" {
  type = string
  default = "~/.ssh/id_rsa.pub"
}

variable "master_count" {
  type = number
  default = "1"
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
}
variable "k8s_cloud_dns_fqdn" {
  type = string
}
variable "gcp_public_dns_zone" {
  type = string
}
variable "gcp_public_dns_fqdn"{
  type = string
}
variable "k8s_cloud_dns_name" {
  type = string
}

variable "vpc_subnet_cidr" {
  type          = string
  default       = "10.240.0.0/24"
}

variable "k8s_pod_cidr" {
  type          = string
  default       = "10.244.0.0/16"
}

variable "k8s_service_cidr" {
  type		= string
  default	= "10.96.0.0/12"
}
