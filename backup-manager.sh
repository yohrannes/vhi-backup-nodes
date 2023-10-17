#!/bin/bash
clear; read -r -p "Digite o CTID:" ctid;
uuid=$( (prlctl list -a || vzlist -a) | grep $ctid | tail -n 1 | grep -o '{[^}]*}' );
backups=($(prlctl backup-list $uuid 2>&1 | grep -v 'Warning:' | grep -v Backup | tail -n 7 | awk '{print $2}'));
datas=($(prlctl backup-list $uuid 2>&1 | grep -v 'Warning:' | grep -v Backup | tail -n 7 | awk '{print $4}'));
horas=($(prlctl backup-list $uuid 2>&1 | grep -v 'Warning:' | grep -v Backup | tail -n 7 | awk '{print $5}'));
#datas-gmt--3 com 
#horas-gmt--3
echo -e 'Backups disponiveis para CTID: \e[32m'$ctid'\e[0m UUID: \e[32m'$uuid'\e[0m'; echo;
for ((i=0;i<=6;i++)); do echo -e '\e[32m'$i - ${datas[$i]} ${horas[$i]}'\e[0m'; done; echo;
read -r -p "Selecione o numero correspondente a data que deseja restaurar :" restore;
echo; echo -e 'SELECIONADA A OPÇÃO \e[32m'$restore - ${datas[$restore]} ${horas[$restore]}'\e[0m CONFIRMA? (Caso caso não aperte CTRL+C dentro de 15 segundos.)'; sleep 15;
echo; echo -e 'Restaurando para \e[91m'${backups[$restore]} ${datas[$restore]} ${horas[$restore]}'\e[0m';
echo "Restaurando para ${backups[$restore]} ${datas[$restore]}";
echo; vzctl stop $ctid; prlctl restore $uuid -t ${backups[$restore]};
vzctl start $ctid; history -c;
