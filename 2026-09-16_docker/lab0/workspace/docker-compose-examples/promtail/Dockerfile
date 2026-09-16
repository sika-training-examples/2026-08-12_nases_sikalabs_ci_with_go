FROM grafana/promtail:3.6.0
USER root
COPY ./promtail.yml /etc/promtail/config.yml
CMD ["-config.file=/etc/promtail/config.yml", "-config.expand-env=true"]
