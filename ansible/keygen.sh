#!/usr/bin/env bash
[ -d keys ] || mkdir keys
echo "[web]" > hosts
for var in "$@" 
do 
    vagrant ssh-config ${var} > result.txt
    identityFile=`cat result.txt | awk '/IdentityFile/' | awk  -F " " '{ print $2 }'`
    port=`cat result.txt | awk '/Port/' | awk  -F " " '{ print $2 }'`
    [ -f keys/${var}_private_key ] && > keys/${var}_private_key
    cp ${identityFile} keys/${var}_private_key
    line="${var} ansible_ssh_host=127.0.0.1 ansible_ssh_port=${port} ansible_ssh_user=vagrant ansible_ssh_private_key_file=keys/${var}_private_key"
    echo ${line} >> hosts
    echo "[${line}] add to hosts file"
    rm -f result.txt
done

#ssh -i ../keys/id_rsa_aws   admin@10.0.0.51 -o "proxycommand ssh -W %h:%p -i ../keys/id_rsa_aws admin@52.90.5.95"
#ssh -i ../keys/id_rsa_aws   admin@10.0.1.56 -o "proxycommand ssh -W %h:%p -i ../keys/id_rsa_aws admin@52.90.5.95"