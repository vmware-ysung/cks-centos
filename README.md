# cks-centos
My terraform,ansible, and kubeadm scripts for CKS exam

Prerequsites:
1. terraform 
2. ansible
3. git
4. google cloud dns (publilc_zone)

Installation steps:
1. git clone this repo
2. review and modify the variable.tf (gcp_project, gcp_region, gcp_credentials, ssh_user, ssh_pub_key)
3. terraform init
4. terraform plan
5. terraform deploy --auto-approve
6. ssh to the master and kubectl away

Destory steps:
1. terraform destroy --auto-approve

Note1: the firewalld rule depends on gcp subnet cidr. Currently it is hard coded in ansible playbook. I am considering a better way to handle this (sending terraform variable to ansible playbook).
