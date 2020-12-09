# Certified Kubernetes Security Specialist Stuffs
---
My terraform, ansible, and kubeadm scripts for CKS exam (K8S v1.20.0)

## Prerequsites (Mac):
- terraform (brew install terraform)
- ansible (brew install ansible)
- git (brew install git)
- kubectl (brew install kubectl)
- GCP Project with a Google cloud managed dns (publilc_zone)

## Installation:
1. git clone this repo
```
git %git clone https://github.com/vmware-ysung/cks-centos.git
git %cd cks-centos
cks-centos % 
```
2. cp variables.tf.example variables.tf
```
cks-centos %mv variables.tf.example variables.tf
```
3. review and modify the variable.tf
```
cks-centos % cat variables.tf
variable "gcp_profile" {
  description = "GCP Configuration"
  type = map
  default = {
    project = "XXXXXXX"
    region = "us-central1"
    zone = "us-central1-c"
    credentials = "~/.ssh/XXXXXXX.json"
  }
  sensitive = true
}

variable "gce_vm" {
  description = "GCE Instance Configuration"
  type = map
  default = {
    instance_type = "n2-standard-2"
    os_project = "ubuntu-os-cloud"
    os_family = "ubuntu-2004-lts"
    boot_disk_size = 200
    ssh_user = "XXXX"
    ssh_pub = "~/.ssh/id_rsa.pub"
  }
}

variable "master_count" {
  description = "K8s Master instances"
  type = number
  default = 1
}

variable "worker_count" {
  description = "K8s worker instances"
  type          = number
  default       = 3
}

variable "k8s_version" {
  type		= string
  default	= "1.20.0"
}

variable "gcp_private_dns_zone" {
  description = "Google Managed DNS zone - private zone name"
  type = map
  default = {
    zone_name = "XXXXX-private"
    dns_name = "cks.vmware.lab."
  } 
}

variable "gcp_public_dns_zone" {
  description = "Google Managed DNS zone - public (preconfig required)"
  type = string
  default = "xxxxx-public-vmware-zone"
}

variable "vpc_subnet_cidr" {
  description  = "VPC custom subnet CIDR"
  type          = string
  default       = "10.240.0.0/24"
}

variable "k8s_pod_cidr" {
  description = "K8s pod subnet CIDR"
  type          = string
  default       = "10.244.0.0/16"
}

variable "k8s_service_cidr" {
  description = "K8s service CIDR"
  type		= string
  default	= "10.96.0.0/12"
}

```
4. terraform init
```
cks-centos %terraform init
```
5. terraform plan
```
cks-centos %terraform plan
```
6. terraform apply --auto-approve
```
cks-centos %terraform apply --auto-approve
```
7. check your ~/.kube/config
```
cks-centos %kubectl get nodes
```
8. kubectl the security stuffs
```
cks-centos %cd kubectl/deployments
deployments %
```

## Destroy:
1. terraform destroy --auto-approve
```
cks-centos %terraform destroy --auto-approve
```

## ToDo:
- [] Instance groups
- [] Kubeadm upgrade
- [] Controlplane ha
