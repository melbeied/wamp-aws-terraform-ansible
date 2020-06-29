Host ${cidr_partial_wildcards}
  ProxyCommand           ssh -i ${private_key} -W %h:%p ec2-user@${bastion_pub_ip}

Host *
  ControlMaster          auto
  ControlPath            ~/.ssh/toto-%r@%h:%p
  ControlPersist         15m