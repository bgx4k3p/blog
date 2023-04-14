---
date: 2023-04-06 12:22
layout: post
title: Setup MicroK8s cluster on Ubuntu Server
subtitle: How-to
description: Step by step instructions to set MicroK8s cluster on Ubuntu 22.04.
image: https://bgx4k3p.github.io/blog/assets/img/awx-large.png
category: linux
tags: linux awx ansible kubernetes helm microk8s
author: bgx4k3p
paginate: true
---

Hey there, welcome to my blog post about creating your own Kubernetes cluster for free! If you're like me and want to experiment with Kubernetes without breaking the bank, then you're in the right place. In this post, I'll show you how to set up your very own Kubernetes cluster using Ubuntu and MicroK8s, all for free!

First things first, let's talk about Kubernetes. It's a powerful open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications. Basically, it's like having your own personal army of robots that take care of all your container-related tasks, so you can sit back and relax.

Now, onto the fun part - setting up your own Kubernetes cluster! Here's what you'll need:

- A machine running latest Ubuntu Server (I'm using Virtual Machine running on ESXi free)
- Preferably 6Gb RAM and 4CPUs or more (Not a hard requirement)
- A sense of adventure

## 1. Install MicroK8s and Kubectl

MicroK8s is a lightweight, standalone version of Kubernetes that's perfect for testing and development. Kubectl is a command-line interface (CLI) tool that is used to interact with Kubernetes clusters. It allows you to deploy, inspect, and manage Kubernetes objects (such as pods, deployments, services, and more) from the command line. Kubectl is a powerful and essential tool for anyone working with Kubernetes, as it provides a convenient and efficient way to manage Kubernetes resources.

To install, open up your terminal and run the following commands:

```bash
# Install
sudo snap install microk8s --classic
sudo snap install kubectl --classic

# Verify the installation
kubectl version --client
microk8s status
```

## 2. Setup permissions

```bash
# Add current user to the microk8s group
sudo usermod -a -G microk8s $USER
newgrp microk8s
```

## 3. Connect Kubectl with MicroK8s

Configure kubectl with the following commands:

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

Next, you'll need to enable the Kubernetes add-ons. This will start up the Kubernetes API server, which is the heart of your cluster. Run the following commands in your terminal:

```bash
# Enable Addons
microk8s enable dashboard

# Create Default token
microk8s kubectl create token default

## OPTIONAL - Use RBAC
# Enable RBAC Addon
microk8s enable rbac

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
```

## 6. Port Forward

The Kubernetes dashboard is not exposed outside of the cluster by default and you won't be able to connect to it. There are many ways to expose it, one of which is port forward.

```bash
# Lookup the IP and Port of the container
kubectl get service -A

# Port Forward
microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard 10443:443 --address 0.0.0.0 &> /dev/null &
```

## 7. Access the Dashboard

First you'll need to retrieve the admin token for authentication. Use the command:

```bash
# Copy the Token for MicroK8s 1.23 or older
microk8s kubectl -n kube-system describe secret $(microk8s kubectl -n kube-system get secret | grep admin-user | awk '{print $1}') | grep token

# Copy the for MicroK8s 1.24 or newer
microk8s kubectl create token default
```

After grabbing the token, open a browser and point to the server IP and port you used with the forward step previously.

<https://IP:10443/>

And that's it! You've just created your very own Kubernetes cluster using Ubuntu and MicroK8s, all for free! Now you can experiment with different deployments, try out different Kubernetes add-ons, and have a blast exploring the world of containerization. Remember, Kubernetes may seem daunting at first, but with a little patience and a lot of trial and error, you'll be a Kubernetes pro in no time.

Happy coding!
