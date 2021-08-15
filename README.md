# k8s_incubator

Scripts to spin off a vanilla k8s cluster on a VM. Tested with AWS EC2 Ubuntu VM.    

## Steps to run

1. Run scripts one by one:

- modifyIpTables.sh
- installDocker.sh
- configureDocker4Cgroup.sh
- installKubeTools.sh 
- createCluster.sh -> -> change CIDR  if needed -> Note outputs
- postClusterCreate.sh
- installDashboard.sh -> Note output token to access dashboard

2. Steps to set up kubectl proxy and access Dashboard UI from local machine:

- Download $HOME/.kube/config to local machine ->. Change Ip address from private IP to public IP -> Also config Security Group for allowing TCP traffic on the port (6443) 

- set KUBECONFIG=C:\<path>\config

- kubectl proxy --insecure-skip-tls-verify  -> Without insecure-skip-tls-verify flag it will give certificate error, as cert was geneated by kubeadm using private IP
 
- To access dashboard, svc needs to be updated to add a name for the port: 
kubectl edit  svc kubernetes-dashboard  -n kubernetes-dashboard
Update port definition to add:  name: https

- Dashboard UI: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:https/proxy/#/login 

## Notes

1. After restrating vm, IP changes. So update config file to new IP

2. Cluster tear down: sudo kubeadm reset

3. Unix check PID for a port: sudo lsof -n -i :2379 | grep LIS

## To Do
 
1. HA Cluster

## Sample Output

---
Output of script createCluster.sh:

***
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 172.31.40.212:6443 --token yugltn.j6nk9lk4j4yhb4z2 \
        --discovery-token-ca-cert-hash sha256:d8ba8d0fc821afb46e07181756c884bf0a8eef2edb937fb5287a8064e1537d78
---

