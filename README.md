# cks-centos
My terraform,ansible, and kubeadm scripts for CKS exam

Prerequsites:
1. terraform 
2. ansible
3. git

Installation steps:
1. git clone this repo
2. review and modify the variable.tf (gcp_project, gcp_region, gcp_credentials, ssh_user, ssh_pub_key)
3. terraform init
4. terraform plan
5. terraform deploy --auto-approve
6. ssh to the master and kubectl away

Destory steps:
1. terraform destroy --auto-approve

Note1: kubeadm will create global routes on your vpc and terraform doesn't pickup the gcp network routes. This causes an error when destory vpc (those routes depends on the vpc).

Note2: the firewalld rule depends on gcp subnet cidr. Currently it is hard coded in ansible playbook. I am considering a better way to handle this (sending terraform variable to ansible playbook).



