FROM linuxserver/wireguard:1.0.20210914

# Normally with docker, you would set these sysctls via the run command, but fly.io isn't really docker
RUN echo '\n\
echo "Writing sysctl settings" \n\
sysctl -w net.ipv4.conf.all.src_valid_mark=1 \n\
sysctl -w net.ipv4.ip_forward=1' >> /etc/s6-overlay/s6-rc.d/init-wireguard-confs/run

# Addresses issue with s6-overlay wanting to run as pid 1
# For more info see https://github.com/pi-hole/docker-pi-hole/issues/1176#issuecomment-1232363970
ENTRYPOINT [ \
    "unshare", "--pid", "--fork", "--kill-child=SIGTERM", "--mount-proc", \
    "perl", "-e", "$SIG{INT}=''; $SIG{TERM}=''; exec @ARGV;", "--", \
    "/init" ]