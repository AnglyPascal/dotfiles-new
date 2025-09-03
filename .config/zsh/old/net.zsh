master_init() {
  MASTER_INTERFACE=enp1s0f0
  sudo systemctl start ifplugd@${MASTER_INTERFACE}
}

master_term() {
  MASTER_INTERFACE=enp1s0f0
  sudo systemctl stop ifplugd@${MASTER_INTERFACE}
}

slave_init() {
  SLAVE_INTERFACE=enp2s0
  sudo systemctl start ifplugd@${SLAVE_INTERFACE}
  sudo systemctl start sshd
}

slave_term() {
  SLAVE_INTERFACE=enp2s0
  sudo systemctl stop ifplugd@${SLAVE_INTERFACE}
  sudo systemctl stop sshd
}

netcp() {
  SLAVE_USER_NAME=ahsan
  SLAVE_IPV6=fe80::249b:901c:3835:9215
  MASTER_INTERFACE=enp1s0f0
  noglob rsync --recursive --perms --human-readable --progress --verbose \
      -e ssh  ${SLAVE_USER_NAME}@[${SLAVE_IPV6}%${MASTER_INTERFACE}]:$1 $2
}

