#!/bin/bash

# please provide .iso file in tmp for this to work, or change its path
# ks.cfg should be placed in current directory

# vm name should be passed in first arg, or default name will be used
if [ -z $1 ]
then
  VMNAME=mkdev-vm-2
else
 VMNAME=$1
fi

/usr/bin/virt-install --name $VMNAME --location /tmp/CentOS-7-x86_64-Minimal-1611.iso --memory=1024 --vcpus=1 --disk size=8 --initrd-inject ks.cfg --extra-args ks=file:/ks.cfg --extra-args="console=ttyS0"
