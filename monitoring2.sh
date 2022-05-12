#!/bin/bash


# Установка prometheus

# Создаём папки и копируем файлы


read -p "mkdir {/etc/,/var/lib/}prometheus" r

if
	[ "$r" = yes ];
then
mkdir {/etc/,/var/lib/}prometheus
elif
	[ "$r" = no ];
then
	echo "ERROR"
	exit
fi




read -p "cp -vi prometheus-*.linux-amd64/prom{etheus,tool} /usr/local/bin" r

if
	[ "$r" = yes ];
then
cp -vi prometheus-*.linux-amd64/prom{etheus,tool} /usr/local/bin

elif
	[ "$r" = no ];
then
	echo "ERROR"
	exit
fi




read -p "cp -rvi prometheus-*.linux-amd64/{console{_libraries,s},prometheus.yml} /etc/prometheus/" r

if
	[ "$r" = yes ];
then
cp -rvi prometheus-*.linux-amd64/{console{_libraries,s},prometheus.yml} /etc/prometheus/

elif
	[ "$r" = no ];
then
	echo "ERROR"
	exit
fi




read -p "chown -Rv prometheus: /usr/local/bin/prom{etheus,tool} /etc/prometheus/ /var/lib/prometheus/" r

if
	[ "$r" = yes ];
then
chown -Rv prometheus: /usr/local/bin/prom{etheus,tool} /etc/prometheus/ /var/lib/prometheus/

elif
	[ "$r" = no ];
then
	echo "ERROR"
	exit
fi


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




