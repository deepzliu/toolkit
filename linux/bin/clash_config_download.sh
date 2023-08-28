#!/bin/bash

configdir='/Users/deepliu/.config/clash'

url=`date +https://clashnode.com/wp-content/uploads/%Y/%m/%Y%m%d.yaml`
filename=`date +$configdir/%Y%m%d.yaml`
echo "URL: $url"
echo "filename: $filename"
curl -Lv "$url" -o "$filename"
