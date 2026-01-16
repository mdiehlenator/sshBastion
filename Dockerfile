FROM alpine

RUN apk add --no-cache openssh

RUN ssh-keygen -A

RUN mkdir -p /tmp/users

COPY ./etc/ /etc/
# COPY ./etc/ssh/sshd_config /etc/ssh/sshd_config
COPY ./users /tmp/users
COPY ./home/ /home

RUN for user in /tmp/users/*; do \
      username=$(basename $user); \
      password=$(cat $user); \
      adduser -h /home/$username -s /bin/sh --disabled-password $username && echo "$username:$password" | chpasswd; \
      chown -R $username:$username /home/$username \
    done

RUN rm -rf /tmp/users

CMD ["/usr/sbin/sshd", "-D", "-e"]
