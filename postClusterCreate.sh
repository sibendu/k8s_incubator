mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install AddOns - https://kubernetes.io/docs/concepts/cluster-administration/addons/
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Rmove Control plane node isolation
kubectl taint nodes --all node-role.kubernetes.io/master-
