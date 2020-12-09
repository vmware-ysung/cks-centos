# cks-centos
My terraform, ansible, and kubeadm scripts for CKS exam (K8S v1.20.0)

Prerequsites (Mac):
- terraform 
- ansible
- git
- Google cloud managed dns (publilc_zone)

Installation steps:
1. git clone this repo
'''
git%git clone https://github.com/vmware-ysung/cks-centos.git
git%cd cks-centos
cks-centos% 
'''
2. cp variables.tf.example variables.tf
3. review and modify the variable.tf
4. terraform init
5. terraform plan
6. terraform apply --auto-approve
7. check your ~/.kube/config
8. kubectl cluster-info

Destory steps:
1. terraform destroy --auto-approve

ToDo:
1. instance group
2. kubeadm upgrade
3. controlplane ha
