#!/bin/bash

## choose a random color for the page background
array[0]="Tomato"
array[1]="Orange"
array[2]="DodgerBlue"
array[3]="MediumSeaGreen"
array[4]="Gray"
array[5]="SlateBlue"
array[6]="Violet"
array[7]="LightGray"
size=${#array[@]}
index=$(($RANDOM % $size))
HEADER_COLOR=${array[$index]}
echo ">>> RANDOM COLOR IS: ${HEADER_COLOR} <<<"

## update index page with a random color
sed -i "s/@COLOR@/${HEADER_COLOR}/" /tmp/index.html

## update index page with server public ip
IPADDR=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
sed -i "s/@IPADDR@/${IPADDR}/" /tmp/index.html

## backup/update index page 
echo ">>> UPDATE INDEX PAGE <<<"
mv /var/www/html/index.nginx-debian.html /var/www/html/index.nginx-debian.bkp
mv /tmp/index.html /var/www/html/index.html

## start nginx
sudo service nginx start

