FROM alpine:latest
RUN apk add --no-cache openssh-server && \
    ssh-keygen -A && \
    adduser -D tunnel && \
    echo "tunnel:tunnel" | chpasswd
COPY sshd_config /etc/ssh/sshd_config
EXPOSE 2222
CMD ["/usr/sbin/sshd", "-D", "-e"]
