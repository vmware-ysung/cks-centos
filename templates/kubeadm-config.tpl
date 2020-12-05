apiVersion: kubeadm.k8s.io/v1beta2
kind: InitConfiguration
nodeRegistration:
  kubeletExtraArgs:
    cloud-provider: gce
    cloud-config: /etc/kubernetes/cloud-config
    feature-gates: "EphemeralContainers=true"
---
apiVersion: kubeadm.k8s.io/v1beta2
kind: ClusterConfiguration
kubernetesVersion: ${k8s_version}
clusterName: kubernetes
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
  - name: cloud-config
    hostPath: /etc/kubernetes/cloud-config
    mountPath: /etc/kubernetes/cloud-config
    pathType: FileOrCreate
  certSANs:
  - cks-master1.c.vmware-ysung.internal
scheduler:
  extraArgs:
    feature-gates: "EphemeralContainers=true"
controllerManager:
  extraArgs:
    feature-gates: "EphemeralContainers=true"
    cloud-provider: gce
    cloud-config: /etc/kubernetes/cloud-config
  extraVolumes:
  - name: cloud-config
    hostPath: /etc/kubernetes/cloud-config
    mountPath: /etc/kubernetes/cloud-config
    pathType: FileOrCreate
