# Easily restore snapshots from Virtuozzo Hybrid Infrastructure

This project uses OpenVZ container-based virtualization technology to perform automatic snapshot restoration. OpenVZ allows the creation and management of isolated containers, each operating as an independent server. This allows for high efficiency and container density per host machine. For more information, check the official documentation.

Docs |
:---:|
[Virtuozzo PaaS Ops Docs (Cluster Overview)](https://www.virtuozzo.com/application-platform-ops-docs/cluster-overview/)|
[OpenVZ Docs](https://wiki.openvz.org/)|

---
## Guide (execute just on VHI User Hosts)

### **Download script.sh**
```
wget https://raw.githubusercontent.com/yohrannes/vhi-backup-nodes/main/backup-manager.sh
```
### **Show last seven snapshots**

- Check your containerid (not nodeid) from admin panel
```
bash backup-manager.sh <CTID>
```
### **Restore snapshots**
```
bash backup-manager.sh <CTID> <BACKUP OPTION [0 - 6]>
```

## Acknowledgements

- My sincere thanks to **[SaveinCloud](https://saveincloud.com)** and the entire support team for providing useful resources and support during the development of this project.
- Thanks also to **[Virtuozzo](https://www.virtuozzo.com/all-supported-products/openvz/)** for making the free software available.
