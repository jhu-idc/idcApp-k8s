#!/bin/bash

# USE AT OWN RISK!!
# simple bash script to wrap a sed command 
# purpose: simplify updating image tag 

old_tag=$1
new_tag=$2
old_minor_release=$(echo "$old_tag" | cut -d\. -f3)
new_minor_release=$(echo "$new_tag" | cut -d\. -f3)

echo "old = $old_minor_release"
echo "new = $new_minor_release"

if [[ -n $old_minor_release && -n $new_minor_release ]]
then
    grep "v0.7.${old_minor_release}" *deployment.yaml | cut -d: -f1 | while read file ; do sed -i "" "s/v0.7.${old_minor_release}/v0.7.${new_minor_release}/" $file; grep v0.7 $file; done
fi


# cd ../overlays/aws/deployment/test
# kustomize build . | kubectl apply -f -
