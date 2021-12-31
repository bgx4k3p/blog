---
title: Install AWX with MicroK8s Cluster on Ubuntu 21.04
categories: linux
tags: linux awx kubernetes cluster microk8s ubuntu
---


How to install MicroK8s and Kubectl on Ubuntu 21.04

## 1. Prerequisites

Make sure to have over 6Gb RAM and 4CPUs! AWX won't install properly otherwise.

## 2. Enable Required AddOns 

```bash
microk8s enable dns storage ingress rbac
```

## 3. Install AWX Operator 

```bash
# Dependencies
sudo apt-get install -y git make

# Get latest release
cd ~
git clone https://github.com/ansible/awx-operator.git
cd awx-operator
git checkout 0.15.0

# Deploy AWX Operator
export NAMESPACE=awx
make deploy

# Check if running
kubectl get pods -n $NAMESPACE
```


## 4. Install AWX 


```bash
# Switch to the AWX namespace
kubectl config set-context --current --namespace=$NAMESPACE

# Create configuration and apply
cd ~
cat << EOF > awx.yaml
---
apiVersion: awx.ansible.com/v1beta1
kind: AWX
metadata:
  name: awx
spec:
  service_type: nodeport
EOF

kubectl apply -f awx.yaml

# Optional: Open another terminal to monitor the install
kubectl logs -f deployments/awx-operator-controller-manager -c awx-manager

```

Wait until all 6 AWX pods are ready, takes a couple of minutes.

```bash
# Check status of pods
kubectl get pods -n $NAMESPACE
```

Example:
```bash
ansible@microk8s:~$ kubectl get --all-namespaces pods
NAMESPACE     NAME                                               READY   STATUS    RESTARTS   AGE
awx           awx-operator-controller-manager-5cdb6dd6cb-25ftr   2/2     Running   0          11m
awx           awx-7d4f664875-v7qk2                               0/4     Pending   0          64s
awx           awx-postgres-0                                     1/1     Running   0          73s

```


## 5. Port Forward 

```bash
# Find the Port/IP
kubectl get service -A

# Port Forward
microk8s kubectl port-forward -n awx service/awx-service 31850:80 --address 0.0.0.0 &> /dev/null &

```


## 6. Login AWX 

```bash
# Get the Admin password
echo Username: admin$'\n'Password: `kubectl  get secret awx-admin-password -o jsonpath='{.data.password}' | base64 --decode`
```
