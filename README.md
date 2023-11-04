# Easily restore snapshots from Virtuozzo Hybrid Infrastructure

This is a script developed to make restoring snapshots in an easier and more simplified way. For more information, check out the official documentation.

Docs |
:---:|
[Virtuozzo PaaS Ops Docs](https://www.virtuozzo.com/application-platform-ops-docs/)|
[OpenVZ Docs](https://wiki.openvz.org/)|

---
## Guide (execute just on VHI user nodes)

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

My sincere thanks to **[SaveinCloud](https://saveincloud.com)** and the entire support team for providing useful resources and support during the development of this project.
