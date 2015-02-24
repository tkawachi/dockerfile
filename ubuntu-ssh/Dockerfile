FROM phusion/baseimage:0.9.16
RUN rm -f /etc/service/sshd/down
RUN /usr/sbin/enable_insecure_key
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 22
CMD ["/sbin/my_init"]
