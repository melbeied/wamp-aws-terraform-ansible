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
#ssh -i ../keys/id_rsa_aws   admin@10.0.0.54 -o "proxycommand ssh -W %h:%p -i ../keys/id_rsa_aws admin@35.180.51.107"



$ mkdir ~/letsencrypt
$ cd ~/letsencrypt
$ certbot certonly \
    --manual \
    --preferred-challenges=dns \
    --email melbeied@gmail.com \
    --agree-tos \
    --config-dir ./config \
    --logs-dir ./logs \
    --work-dir ./workdir \
    -d melbeied.net -d *.melbeied.net



$ whois mendozajesus.com | grep -i "name"
Air-de-Mohammed:ansible mohammedelbeied$ whois melbeied.net | grep -i "name server"
   Name Server: NS-1063.AWSDNS-04.ORG
   Name Server: NS-1786.AWSDNS-31.CO.UK
   Name Server: NS-346.AWSDNS-43.COM
   Name Server: NS-932.AWSDNS-52.NET
Name Server: ns-1063.awsdns-04.org
Name Server: ns-1786.awsdns-31.co.uk
Name Server: ns-346.awsdns-43.com
Name Server: ns-932.awsdns-52.net
Air-de-Mohammed:ansible mohammedelbeied$ dig melbeied.net SOA +trace | tail -n 12
melbeied.net.		172800	IN	NS	ns-346.awsdns-43.com.
melbeied.net.		172800	IN	NS	ns-932.awsdns-52.net.
melbeied.net.		172800	IN	NS	ns-1063.awsdns-04.org.
melbeied.net.		172800	IN	NS	ns-1786.awsdns-31.co.uk.
A1RT98BS5QGC9NFI51S9HCI47ULJG6JH.net. 86400 IN NSEC3 1 1 0 - A1RUUFFJKCT2Q54P78F8EJGJ8JBK7I8B  NS SOA RRSIG DNSKEY NSEC3PARAM
A1RT98BS5QGC9NFI51S9HCI47ULJG6JH.net. 86400 IN RRSIG NSEC3 8 2 86400 20200712063623 20200705052623 36059 net. rvqNGE1Xq+7I60zFHS/4ncD0o+fQysSo1FUVzvhEDlB5vsR99zEhIPC2 blDD2EBcr5ryA9zlRZMUkygQI4qMKn+G+m/OExx49yKPCJ1uhEWtSY7E YYlbJDwz/N2dBnr4i30xuxcWJ9Hs9jJ3fVlipUcpQGSljpee57FweGKw H0yUbvzBwU4zFxJdNoJwx12byKzCQw0rmI06GN0cpMX54w==
V1S1QJAUPV1RPCR8RLIUKPEM60G7R08S.net. 86400 IN NSEC3 1 1 0 - V1SEGRRJ12Q4662VJANMUIJNK656P5VM  NS DS RRSIG
V1S1QJAUPV1RPCR8RLIUKPEM60G7R08S.net. 86400 IN RRSIG NSEC3 8 2 86400 20200710063315 20200703052315 36059 net. J5rajbL1gc0QKElWsIPlDBi9hclPtWl1koeJYpeqdfyolAPFkLshzwWv 1Oi7ag5j1zi0U5ZjoT5Rv26laqJDf2J5lRhkJswabEsP9FoSMokLP9AD ndl3bWprD2EaoLxlL+sHGOgXQtrXpy/Q2Qhkba0K3W6Z05PH3PkwO0C0 NoJl0RanHIqU7eiV14ThcHBP3Rv3SsxbD7LdQZx1hIbgig==
;; Received 743 bytes from 192.12.94.30#53(e.gtld-servers.net) in 73 ms

;; Received 30 bytes from 205.251.195.164#53(ns-932.awsdns-52.net) in 42 ms



[vm]
vm-selinium ansible_ssh_host=192.168.34.100 ansible_ssh_port=22 ansible_ssh_user=vagrant ansible_ssh_private_key_file=/workspace/vagrant/selinium/.vagrant/machines/jenkis-selinium-vm/virtualbox/private_key"