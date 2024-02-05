#!/bin/bash
checkbackups(){ 
    ctid=$1; restore=$2;
    uuid=$( (prlctl list -a || vzlist -a) | grep "$ctid" | tail -n 1 | grep -o '{[^}]*}' );

    if [[ "$uuid" == "" ]]; then echo -e '\e[91m\nSnapshot not found\n\e[0m'; sleep 4; exit 0; fi;

    backups=($(prlctl backup-list "$uuid" 2>&1 | grep -v 'Warning:' | grep -v Backup | tail -n 7 | awk '{print $2}'));
    datas=($(prlctl backup-list "$uuid" 2>&1 | grep -v 'Warning:' | grep -v Backup | tail -n 7 | awk '{print $4}'));
    horas=($(prlctl backup-list "$uuid" 2>&1 | grep -v 'Warning:' | grep -v Backup | tail -n 7 | awk '{print $5}'));

    echo -e '\nDisponible backups for CTID: \e[32m'"$ctid"'\e[0m UUID: \e[32m'"$uuid"'\e[0m\n';

    for ((i=0; i<=6; i++)); do
        if [[ ! "${datas[$i]}" == */* ]]; then
            datas[i]=""; horas[i]="";
        fi;
        if [[ "${datas[$i]}" != "" ]]; then
            echo -e '\e[32m'$i - "${datas[$i]}" "${horas[$i]}"'\e[0m';
        fi;
    done;
    echo;
    if [[ "$2" == "" ]]; then exit 0; else restorenode "$2";fi

};

restorenode(){ 

    echo -e '\nSELECTED THE OPTION \e[32m'"$restore" - "${datas[$restore]}" "${horas[$restore]}"'\e[0m CONFIRM? (If not tap CTRL+C in 15 seconds.)\n';sleep 15;

    if [[ "${datas[$restore]}" == "" ]]; then
        echo -e '\e[91mSelected snapshot not found\n\e[0m'
    else
        echo -e '\nRestoring from \e[91m'"${backups[$restore]}" "${datas[$restore]}" "${horas[$restore]}"'\e[0m\n';
        vzctl stop "$ctid"; prlctl restore "$uuid" -t "${backups[$restore]}";
        vzctl start "$ctid"; echo -e '\n\e[91mRestore finish\e[0m \n\n Writen by Yohrannes Santos Bigoli.\n'; history -c;
    fi;
};

    if [[ -n "$1" || -n "$2" ]]; then checkbackups "$1" "$2"; elif [[ "$1" == "" || "$2" == "" ]]; then exit 0;fi
