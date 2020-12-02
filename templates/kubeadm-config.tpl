apiVersion: kubeadm.k8s.io/v1beta2
kind: ClusterConfiguration
kubernetesVersion: ${k8s_version}
cloud-provider: gce
networking:
  dnsDomain: ${k8s_service_dns}
  podSubnet: ${k8s_pod_cidr} 
apiServer:
  extraArgs:
    feature-gates: "EphemeralContainers=true"
    cloud-provider: gce
    cloud-config: /etc/kubernetes/cloud
  extraVolumes:
  - name: cloud-config
    hostPath: /etc/kubernetes/cloud-config
    mountPath: /etc/kubernetes/cloud
    pathType: FileOrCreate
  certSANs:
  - "cks-master1.c.vmware-ysung.internal"
  - "cks.${k8s_service_dns}"
scheduler:
  extraArgs:
    feature-gates: "EphemeralContainers=true"
controllerManager:
  extraArgs:
    feature-gates: "EphemeralContainers=true"
    cloud-provider: gce
    cloud-config: /etc/kubernetes/cloud
  extraVolumes:
  - name: cloud-config
    hostPath: /etc/kubernetes/cloud-config
    mountPath: /etc/kubernetes/cloud
    pathType: FileOrCreate
---
apiVersion: kubeadm.k8s.io/v1beta2
kind: InitConfiguration
nodeRegistration:
  kubeletExtraArgs:
    "feature-gates": "EphemeralContainers=true"