#!/bin/sh
# укажите имя интерфейса, иначе скрипт попытается выбрать его автоматически
#DEV='eth0'
# проверить можно командой “ip a”
DEV='ens3'
# Значение подсети
# изменяется в соответствии с конфигурацией 
PRIVATE=10.8.0.0/24
if [ -z "$DEV" ]; then
DEV="$(ip route | grep default | head -n 1 | awk '{print $5}')"
fi
# Включаем маршрутизация транзитных IP–пакетов, чтобы 
# они уходили на внешний интерфейс
sysctl net.ipv4.ip_forward=1
# Проверка блокировки перенаправленного трафика iptables 
iptables -I FORWARD -j ACCEPT
# Преобразование адресов (NAT) 
iptables -t nat -I POSTROUTING -s $PRIVATE -o $DEV -j MASQUERADE