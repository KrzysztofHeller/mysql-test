#!/bin/bash
sed -i 's/AllowTcpForwarding no/AllowTcpForwarding yes/' /etc/ssh/sshd_config
sed -i 's/#AllowTcpForwarding/AllowTcpForwarding/' /etc/ssh/sshd_config
echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config
