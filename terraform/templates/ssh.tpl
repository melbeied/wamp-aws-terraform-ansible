Host bastion
  Hostname ${bastion_pub_ip}
  User ${sys_user}
  IdentityFile  ${private_key}

Host ${cidr_partial_wildcards}.*
  IdentityFile  ${private_key}
  User ${sys_user}
  ProxyCommand ssh -F ssh.cfg -W %h:%p  bastion

Host *
 ControlMaster   auto
 ControlPath     ~/.ssh/mux-%r@%h:%p
 ControlPersist  15m