#!/bin/bash 

###################################################################
#Script Name	:                                                                                               
#Description	:                                                                                 
#Args         	:                                                                                           
#Author       	: Tharaka Mahabage
#Email         	: tharaka.mahabage.01@gmail.com
###################################################################

echo Enter namespace
read namespacename

echo Enter resource to export
read resourcename

kubectl get $resourcename -n $namespacename | awk {'print $1'} |grep -v NAME|awk {'print "kubectl get $resourcename", $1, "-n $namespacename -oyaml>",$1,".yaml"'} >get_$resourcename.sh
sed -i 's, .yaml,.yaml,g' get_$resourcename.sh
chmod 755 get_$resourcename.sh
sh $PWD/get_$resourcename.sh
