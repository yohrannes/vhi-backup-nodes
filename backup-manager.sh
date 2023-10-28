#!/bin/bash
# wget https://raw.githubusercontent.com/yohrannes/vhi-backup-nodes/main/backup-manager.sh
# How do use
# bash $PWD/backup-manager.sh CTID BACKUPID
checkbackups() {
    ctid=$1; restore=$2; uuid=$( (prlctl list -a || vzlist -a) | grep "$ctid" | tail -n 1 | grep -o '{[^}]*}' );
    if [[ "$uuid" == "" ]]; then
        echo -e '\e[91mSnapshot não encontrado\e[0m'
        sleep 4
        exit 0
    fi
    backups=($(prlctl backup-list "$uuid" 2>&1 | grep -v 'Warning:' | grep -v Backup | tail -n 7 | awk '{print $2}')); datas=($(prlctl backup-list "$uuid" 2>&1 | grep -v 'Warning:' | grep -v Backup | tail -n 7 | awk '{print $4}')); horas=($(prlctl backup-list "$uuid" 2>&1 | grep -v 'Warning:' | grep -v Backup | tail -n 7 | awk '{print $5}'));
    for ((i=0; i<=6; i++)); do
        if [[ ! "${datas[$i]}" == */* ]]; then
            datas[i]=""; horas[i]="";
        fi
    done;
    for ((i=0;i<=6;i++)); do
        data_brasil[i]=$(date -d "${datas[$i]}" +"%d/%m/%Y"); hora_ajustada[i]=$(date -d "${horas[$i]} 3 hours ago" +"%H:%M:%S");
        if [[ "${horas[$i]}" < "18:00:00" ]]; then
            data_brasil[i]=$(date -d "${datas[$i]} 1 day ago" +"%d/%m/%Y");
        fi
    done;
    echo -e 'Backups disponiveis para CTID: \e[32m'"$ctid"'\e[0m UUID: \e[32m'"$uuid"'\e[0m';echo;
    for ((i=0;i<=6;i++)); do echo -e '\e[32m'$i - "${data_brasil[$i]}" "${hora_ajustada[$i]}"'\e[0m'; done;echo;

    if [[ "$2" == "" ]]; then
        exit 0
    else
        restorenode "$2"
    fi
}
restorenode () {
    echo; echo -e 'SELECIONADA A OPÇÃO \e[32m'"$restore" - "${datas[$restore]}" "${horas[$restore]}"'\e[0m CONFIRMA? (Caso caso não aperte CTRL+C dentro de 15 segundos.)';sleep 15; echo; echo -e 'Restaurando para \e[91m'"${backups[$restore]}" "${datas[$restore]}" "${horas[$restore]}"'\e[0m'; echo "Restaurando para ${backups[$restore]} ${datas[$restore]}"; echo; vzctl stop "$ctid"; prlctl restore "$uuid" -t "${backups[$restore]}"; vzctl start "$ctid"; history -c;
}
if [[ -n "$1" || -n "$2" ]]; then
    checkbackups "$1" "$2"
elif [[ "$1" == "" || "$2" == "" ]]; then
    exit 0
fi