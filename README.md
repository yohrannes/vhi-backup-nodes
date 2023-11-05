# Restaure snapshots na Virtuozzo Hybrid Infrastructure

Este projeto utiliza a tecnologia de virtualização baseada em contêineres OpenVZ para realizar a restauração automática do snapshot. OpenVZ permite a criação e gerenciamento de contêineres isolados, cada um operando como um servidor independente. Isso permite uma alta eficiência e densidade de contêineres por máquina host. para mais informações confira na documentação oficial.

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

- Meus sinceros agradecimentos à **[SaveinCloud](https://saveincloud.com)** e toda equipe por fornecer recursos úteis e apoio durante o desenvolvimento deste projeto.
- Agradecimentos também a **[Virtuozzo](https://www.virtuozzo.com/all-supported-products/openvz/)** na disponibilização do software livre.
