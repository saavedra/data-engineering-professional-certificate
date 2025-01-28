#! /bin/bash
sudo yum -y update  
sudo yum -y install postgresql15.x86_64
sudo yum -y install yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
