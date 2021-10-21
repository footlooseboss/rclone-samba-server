FROM dperson/samba:latest
RUN apk --no-cache --no-progress upgrade && apk --no-cache --no-progress add unzip supervisor fuse
COPY supervisord.conf /etc/supervisord.conf
RUN wget https://downloads.rclone.org/v1.56.2/rclone-v1.56.2-linux-amd64.zip && \
    unzip rclone*.zip && cd rclone* && cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && chmod 755 /usr/bin/rclone && rm -R /rclone*
RUN mkdir -p /mnt/remote
VOLUME ["/rclone/config", "/rclone/cache"]
# CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
