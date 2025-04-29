FROM  grafana/promtail:3.2.0
COPY config.yml /etc/promtail/config.yml
CMD [ "-config.file=/etc/promtail/config.yml", "-config.expand-env" ]
