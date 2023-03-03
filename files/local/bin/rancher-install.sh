#!/bin/sh

if [ -n "$RANCHER_IMAGE" ]
then
    RANCHER_IMAGE=rancher/rancher:v2.7.1
fi

if [ -n "$RANCHER_DATADIR" ]
then
    RANCHER_DATADIR="/var/local/lib/rancher/rancher"
fi

CONTAINER_NAME=rancher

sudo k3d cluster create k3d

echo "Remove old rancher instance for upgrade ..."
sudo docker stop $CONTAINER_NAME
sudo docker rm $CONTAINER_NAME

sudo docker pull $RANCHER_IMAGE

sudo mkdir -p $RANCHER_DATADIR/{kubelet,log,rancher,cni}

sudo docker run --name $CONTAINER_NAME \
    -p 7080:80 -p 7443:443 \
    -d --restart=unless-stopped --privileged \
    -v $RANCHER_DATADIR/kubelet:/var/lib/kubelet \
    -v $RANCHER_DATADIR/rancher:/var/lib/rancher \
    -v $RANCHER_DATADIR/log:/var/log \
    -v $RANCHER_DATADIR/cni:/var/lib/cni \
    $RANCHER_IMAGE
