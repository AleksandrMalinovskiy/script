#!/bin/bash
mkdir {/etc/,/var/lib/}prometheus
cp -vi prometheus-*.linux-amd64/prom{etheus,tool} /usr/local/bin
cp -rvi prometheus-*.linux-amd64/{console{_libraries,s},prometheus.yml} /etc/prometheus/
chown -Rv prometheus: /usr/local/bin/prom{etheus,tool} /etc/prometheus/ /var/lib/prometheus/

# Настраиваем сервис

cd /home/

mv /home/monitoring/prometheus.service /etc/systemd/system/

# Конфиг prometheus
rm -f /etc/prometheus/prometheus.yml
mv /home/monitoring/prometheus.yml /etc/prometheus/

# Запускаем сервис Prometheus
systemctl daemon-reload
systemctl start prometheus
systemctl status prometheus
systemctl enable prometheus




