#!/bin/bash

# Установка prometheus
read -p "Создать папку prometheus?" r

if
	[ "$r" = y ];
then
mkdir {/etc/,/var/lib/}prometheus
elif
	[ "$r" = n ];
then
	echo "ERROR"
	exit
fi

read -p "Копируем файлы?" r

if
	[ "$r" = y ];
then
cp -vi prometheus-*.linux-amd64/prom{etheus,tool} /usr/local/bin

elif
	[ "$r" = n ];
then
	echo "ERROR"
	exit
fi

cp -rvi prometheus-*.linux-amd64/{console{_libraries,s},prometheus.yml} /etc/prometheus/

read -p "Изменяем владельца?" r

if
	[ "$r" = y ];
then
chown -Rv prometheus: /usr/local/bin/prom{etheus,tool} /etc/prometheus/ /var/lib/prometheus/

elif
	[ "$r" = n ];
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




