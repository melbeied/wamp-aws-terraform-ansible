#!/bin/sh
    ### disable seLinux 	
	#setenforce 0
	#sed -i 's/SELINUX=\(enforcing\|permissive\)/SELINUX=disabled/g' /etc/selinux/config


	#sudo yum -y update
    rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	#sudo yum -y install epel-repo
	
	### install ansible 	
	sudo yum -y install ansible