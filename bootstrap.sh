#!/bin/bash

# Switch to super user. Yum and Docker requires super user privileges
sudo -s

# Disable swap
swapoff -a

# Ensure all packages up-to-date
yum update -y

# Disable SELinux
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforced/SELINUX=disabled/g' /etc/sysconfig/selinux

# Enable firewall
systemctl enable firewalld
systemctl start firewalld

# Set firewall rules

# api-server
firewall-cmd --permanent --add-port=6443/tcp

# etcd
firewall-cmd --permanent --add-port=2379-2380/tcp

# kubelet
firewall-cmd --permanent --add-port=10250/tcp

# kube-scheduler
firewall-cmd --permanent --add-port=10251/tcp

# kube-controller-manager
firewall-cmd --permanent --add-port=10252/tcp

# Reload firewall
firewall-cmd --reload

modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum install kubeadm docker -y

systemctl enable docker
systemctl enable kubelet

