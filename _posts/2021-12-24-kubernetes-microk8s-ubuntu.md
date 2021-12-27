---
title: "Setup MicroK8s cluster on Ubuntu 21.04"
categories: linux
tags: setup kubernetes ubuntu microk8s
---

How to setup MicroK8s cluster on Ubuntu 21.04
======

## 1. Install MicroK8s and Kubectl

```bash
sudo snap install microk8s --classic
sudo snap install kubectl --classic
```

## 2. Setup permissions

```bash
# Add current user and gain access to .kube caching
sudo usermod -a -G microk8s $USER
newgrp microk8s

# Verify the installation
kubectl version --client
microk8s status
```

## 3. Connect Kubectl with MicroK8s

```bash
cd $HOME
mkdir .kube
cd .kube
microk8s config > config
kubectl config get-contexts
```

## 4. Start the cluster and check status

```bash
microk8s start && sleep 5
microk8s kubectl get nodes
microk8s kubectl get pods -A

```


## 5. Setup Dashboard

```bash
# Enable Dashboard Addon
microk8s enable dashboard

# Enable RBAC Addon
microk8s enable rbac

# Enable Ingress Addon
microk8s enable ingress

# Create the Admin user: dashboard-adminuser.yaml
cd ~
cat << EOF > dashboard-adminuser.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system
EOF

microk8s kubectl apply -f dashboard-adminuser.yaml

# Create the Admin role binding: adminuser-rolebinding.yaml

cd ~
cat << EOF > adminuser-rolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
EOF

microk8s kubectl apply -f adminuser-rolebinding.yaml

# Copy the Token
microk8s kubectl -n kube-system describe secret $(microk8s kubectl -n kube-system get secret | grep admin-user | awk '{print $1}') | grep token

```

## 6. Port Forward

```bash
# Lookup the IP and Port of the container
kubectl get service -A

# Port Forward
microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard 10443:443 --address 0.0.0.0 &> /dev/null &
```

## 7. Access the Dashboard

https://127.0.0.1:10443/
