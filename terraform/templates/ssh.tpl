Host ${cidr_partial_wildcards}
  ProxyCommand           ssh -i ${private_key}  -W %h:%p ${sys_user}@${bastion_pub_ip}

Host *
  ControlMaster          auto
  ControlPath            ~/.ssh/admin-%r@%h:%p
  ControlPersist         15m