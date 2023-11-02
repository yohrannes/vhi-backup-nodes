# Restaure snapshots na Virtuozzo Hybrid Infrastructure

## Guia (execute somente nos usernodes)

### **Faça download do script.sh**
```
wget https://raw.githubusercontent.com/yohrannes/vhi-backup-nodes/main/backup-manager.sh
```
### **Informar últimas sete snapshots**
- Confira o id do container (**ctid** não nodeid) e execute o comando
```
bash backup-manager.sh <CTID>
```
### **Restaure snapshots**
```
bash backup-manager.sh <CTID> <BACKUP OPTION [0 - 6]>
```
