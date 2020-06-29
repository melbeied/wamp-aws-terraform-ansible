[bastion]
${bastion_pub_ip}

[web]
%{ for ip in provate_ips ~}
${ip}
%{ endfor ~}