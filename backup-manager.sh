#!/bin/bash
checkbackups(){ 
    ctid=$1;restore=$2;
    uuid=$( (prlctl list -a || vzlist -a) | grep "$ctid" | tail -n 1 | grep -o '{[^}]*}' );
    
    if [[ "$uuid" == "" ]]; then echo -e '\e[91mSnapshot não encontrado\e[0m'; sleep 4; exit 0; fi;
    
    while IFS= read -r line; do backups+=("$line");done < <(prlctl backup-list "$uuid" 2>&1 | grep -v 'Warning:' | grep -v Backup | tail -n 7 | awk '{print $2}');
    
    while IFS= read -r line; do datas+=("$line");done < <(prlctl backup-list "$uuid" 2>&1 | grep -v 'Warning:' | grep -v Backup | tail -n 7 | awk '{print $4}');
    
    while IFS= read -r line; do horas+=("$line");done < <(prlctl backup-list "$uuid" 2>&1 | grep -v 'Warning:' | grep -v Backup | tail -n 7 | awk '{print $5}');
    
    echo -e '\nBackups disponiveis para CTID: \e[32m'"$ctid"'\e[0m UUID: \e[32m'"$uuid"'\e[0m\n';
    
    for ((i=0; i<=6; i++)); do 
        if [[ ! "${datas[$i]}" == */* ]]; then 
            datas[i]=""; horas[i]="";
        fi;
    done;
    
    for ((i=0; i<=6; i++)); do
        if [[ ! "${backups[$i]}" == *-* ]]; then 
            backups[i]=""; backups[i]=""; 
        fi; 
    done;
    
    for ((i=0;i<=6;i++)); do 
    if [[ "${datas[$i]}" != "" ]]; then 
        data_brasil[i]=$(date -d "${datas[$i]}" +"%d/%m/%Y");
        hora_ajustada[i]=$(date -d "${horas[$i]} 3 hours ago" +"%H:%M:%S");
    
    if [[ "${horas[$i]}" < "18:00:00" ]]; then 
        data_brasil[i]=$(date -d "${datas[$i]} 1 day ago" +"%d/%m/%Y");
    fi;
    
    echo -e '\e[32m'$i - "${data_brasil[$i]}" "${hora_ajustada[$i]}"'\e[0m';fi;done;
     
    if [[ "$2" == "" ]]; then 
        exit 0;
    else 
        restorenode "$2";
    fi;
};
     
     
restorenode(){
    echo -e '\nSELECIONADA A OPÇÃO \e[32m'"$restore" - "${data_brasil[$restore]}" "${hora_ajustada[$restore]}"'\e[0m CONFIRMA? (Caso não aperte CTRL+C dentro de 15 segundos.)\n';
    sleep 15;
    
    if [[ "${data_brasil[$restore]}" == "" ]]; then
        echo -e '\e[91mSnapshot selecionado não encontrado\n\e[0m';
        
    else echo -e '\nRestaurando para \e[91m'"${backups[$restore]}" "${data_brasil[$restore]}" "${hora_ajustada[$restore]}"'\e[0m\n';
    
    #vzctl stop "$ctid";
    
    #prlctl restore "$uuid" -t "${backups[$restore]}";
    
    #vzctl start "$ctid";

    if vzctl stop "$ctid" | grep -q "Container was stopped"; then
        prlctl restore "$uuid" -t "${backups[$restore]}";
        vzctl start "$ctid";
    elif prlctl stop "$uuid" | grep -q "The VM has been successfully stopped"; then
        prlctl restore "$uuid" -t "${backups[$restore]}";
        prlctl start "$uuid";
    else
        echo "Erro - Container ainda em execução...."
        exit 1
    fi
    
    echo -e '\n\e[91mRestauração finalizada\e[0m \n\n Escrito por Yohrannes Santos Bigoli.\n'; 
    
    history -c;fi;};if [[ -n "$1" || -n "$2" ]]; then checkbackups "$1" "$2"; elif [[ "$1" == "" || "$2" == "" ]]; then exit 0;fi