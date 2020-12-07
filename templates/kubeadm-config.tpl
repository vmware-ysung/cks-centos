apiVersion: kubeadm.k8s.io/v1beta2
kind: InitConfiguration
nodeRegistration:
  kubeletExtraArgs:
    feature-gates: "EphemeralContainers=true"
    cloud-provider: gce
    cloud-config: /etc/kubernetes/cloud-config
---
apiVersion: kubeadm.k8s.io/v1beta2
kind: ClusterConfiguration
kubernetesVersion: ${k8s_version}
api:
  advertiseAddress: ${api_public_ip}
cloud-provider: gce
networking:
  podSubnet: ${k8s_pod_cidr} 
apiServer:
  extraArgs:
    authorization-mode: Node,RBAC
    feature-gates: "EphemeralContainers=true"
    cloud-provider: gce
    cloud-config: /etc/kubernetes/cloud-config
  extraVolumes:
  - name: cloud
    hostPath: /etc/kubernetes/cloud-config
    mountPath: /etc/kubernetes/cloud-config
  certSANs:
  - "*.c.vmware-ysung.internal"
  - "*.${k8s_private_dns_name}"
  - "${api_public_ip}"
  - "cks.phartdoctor.us"
scheduler:
  extraArgs:
    feature-gates: "EphemeralContainers=true"
controllerManager:
  extraArgs:
    feature-gates: "EphemeralContainers=true"
    cloud-provider: gce
    cloud-config: /etc/kubernetes/cloud-config
  extraVolumes:
  - name: cloud
    hostPath: /etc/kubernetes/cloud-config
    mountPath: /etc/kubernetes/cloud-config
