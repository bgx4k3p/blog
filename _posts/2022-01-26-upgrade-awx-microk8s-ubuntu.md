---
title: "Upgrade AWX on MicroK8s cluster"
categories: linux
tags: awx linux how-to kubernetes ubuntu microk8s
---

How to upgrade AWX with MicroK8s clusters on Ubuntu 21.04

## 1. Pull the Latest AWX Operator

Find the latest version of AWX Operator: https://github.com/ansible/awx-operator/releases 

```bash
# Pull the latest version from GIT
cd ~/awx-operator
git checkout 0.16.0
```

## 2. Upgrade AWX Operator

```bash
# Switch to the correct namespace
export NAMESPACE=awx

# Deploy
ansible@microk8s:~/awx-operator$ make deploy
```

Example results:
```bash
namespace/awx unchanged
customresourcedefinition.apiextensions.k8s.io/awxbackups.awx.ansible.com unchanged
customresourcedefinition.apiextensions.k8s.io/awxrestores.awx.ansible.com unchanged
customresourcedefinition.apiextensions.k8s.io/awxs.awx.ansible.com configured
serviceaccount/awx-operator-controller-manager unchanged
role.rbac.authorization.k8s.io/awx-operator-awx-manager-role configured
role.rbac.authorization.k8s.io/awx-operator-leader-election-role unchanged
clusterrole.rbac.authorization.k8s.io/awx-operator-metrics-reader unchanged
clusterrole.rbac.authorization.k8s.io/awx-operator-proxy-role unchanged
rolebinding.rbac.authorization.k8s.io/awx-operator-awx-manager-rolebinding unchanged
rolebinding.rbac.authorization.k8s.io/awx-operator-leader-election-rolebinding unchanged
clusterrolebinding.rbac.authorization.k8s.io/awx-operator-proxy-rolebinding unchanged
configmap/awx-operator-awx-manager-config unchanged
service/awx-operator-controller-manager-metrics-service unchanged
deployment.apps/awx-operator-controller-manager configured
```

## 3. Check AWX

AWX Operator will upgrade AWX Tower automatically. It is important to have enough CPU and Memory for the upgrade to work. Recommended 16Gb RAM and 6 CPU cores. The AWX data will be migrate automatically and the old pods will be terminated.

```bash
ansible@microk8s:~/awx-operator$ kubectl get pods -n $NAMESPACE
NAME                                               READY   STATUS    RESTARTS        AGE
awx-postgres-0                                     1/1     Running   13 (2d3h ago)   39d
awx-7d4f664875-7gvxz                               4/4     Running   56 (47h ago)    39d
awx-operator-controller-manager-6795f9f5f5-fxvd6   2/2     Running   0               96s
awx-75486fdfb8-m2l9q                               0/4     Pending   0               48s
```

Optional: Open another terminal to monitor the install live

```bash
kubectl logs -f deployments/awx-operator-controller-manager -c awx-manager
```

