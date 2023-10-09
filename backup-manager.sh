clear; read -r -p "Digite o CTID:" ctid; uuid=$( (prlctl list -a || vzlist -a) | grep $ctid | tail -n 1 | grep -o '{[^}]*}' ); backups=($(prlctl backup-list $uuid 2>&1 | grep -v 'Warning:' | grep -v Backup | tail -n 7 | awk '{print $2}')); datas=($(prlctl backup-list $uuid 2>&1 | grep -v 'Warning:' | grep -v Backup | tail -n 7 | awk '{print $4}')); echo "Backups disponiveis para $ctid"; echo; for ((i=0;i<=6;i++)); do echo "$i - ${datas[$i]}"; done; echo; read -r -p "Selecione o numero correspondente a data que deseja restaurar :" restore; echo; echo "Restaurando para ${backups[$restore]} ${datas[$restore]}"; echo "Restaurando para ${backups[$restore]} ${datas[$restore]}"; echo; vzctl stop $ctid; prlctl restore $uuid -t ${backups[$restore]}; vzctl start $ctid; history -c;