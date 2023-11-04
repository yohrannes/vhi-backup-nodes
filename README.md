# Restaure snapshots na Virtuozzo Hybrid Infrastructure

Este é um script desenvolvido para fazer a restauração de snapshots de uma forma mais fácil e simplificada para mais informações confira na documentação oficial.

Docs |
:---:|
[Virtuozzo PaaS Ops Docs (Cluster Overview)](https://www.virtuozzo.com/application-platform-ops-docs/cluster-overview/)|
[OpenVZ Docs](https://wiki.openvz.org/)|

---
## Guia (execute somente nos usernodes)

### **Faça download do script.sh**
```
wget https://raw.githubusercontent.com/yohrannes/vhi-backup-nodes/main-pt/backup-manager.sh
```
### **Informar últimas sete snapshots**
- Confira o id do container (**ctid** não nodeid) e execute o comando
```
bash backup-manager.sh <CTID>
```
### **Restaure**
```
bash backup-manager.sh <CTID> <OPÇÃO DO BACKUP [0 - 6]>
```

## Agradecimentos

Meus sinceros agradecimentos à **[SaveinCloud](https://saveincloud.com)** e toda equipe de suporte por fornecer recursos úteis e apoio durante o desenvolvimento deste projeto.
