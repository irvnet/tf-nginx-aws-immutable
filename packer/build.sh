#!/bin/bash

# ami-build

echo 'prep...'
ARTIFACT=`packer build -machine-readable ubuntu-nginx-ami.json|awk -F, '$0 ~/artifact,0,id/ {print $6}'`
AMI_ID=`echo $ARTIFACT | cut -d ':' -f2`

## update source image for tf
echo '** update terraform variable with new ami name...'
echo 'variable "AMI_ID" { default = "'${AMI_ID}'" }' > ../provision/amivar.tf

## deploy
#echo 'deploy nginx topology... '
#cd ../provision
#terraform init
#terraform apply -auto-approve

