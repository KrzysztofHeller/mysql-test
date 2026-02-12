FROM alpine:latest
RUN apk add --no-cache openssh-server && \
    ssh-keygen -A && \
    adduser -D tunnel && \
    echo "tunnel:tunnel" | chpasswd && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/' /etc/ssh/sshd_config && \
    echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config
EXPOSE 2222
CMD ["/usr/sbin/sshd", "-D", "-p", "2222", "-e"]
