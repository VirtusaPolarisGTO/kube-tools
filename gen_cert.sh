#!/bin/bash


###################################################################
#Script Name	:                                                                                               
#Description	:                                                                                 
#Args         	:                                                                                           
#Author       	: Tharaka Mahabage
#Email         	: tharaka.mahabage.01@gmail.com
###################################################################

hostnameis=`hostname`

openssl req -newkey rsa:4096 \
           -keyout tls.key \
           -nodes \
           -out tls.csr \
           -subj "/CN=$hostnameis"

sudo openssl x509 -req -in tls.csr \
                  -CA /etc/kubernetes/pki/ca.crt \
                  -CAkey /etc/kubernetes/pki/ca.key \
                  -CAcreateserial \
                  -out tls.crt \
                  -days 365

userid=`id`
sudo chown $userid:$userid tls.crt
