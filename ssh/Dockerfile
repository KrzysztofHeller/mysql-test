FROM alpine:latest
RUN apk add --no-cache openssh-server && \
    ssh-keygen -A && \
    adduser -D tunnel && \
    echo "tunnel:tunnel" | chpasswd && \
    sed -i 's/AllowTcpForwarding no/AllowTcpForwarding yes/' /etc/ssh/sshd_config
COPY keys/authorized_keys /home/tunnel/.ssh/authorized_keys
RUN chown -R tunnel:tunnel /home/tunnel/.ssh && \
    chmod 700 /home/tunnel/.ssh && \
    chmod 600 /home/tunnel/.ssh/authorized_keys
EXPOSE 2222
CMD ["/usr/sbin/sshd", "-D", "-p", "2222", "-e"]
