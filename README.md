# Easily restore snapshots on Virtuozzo Hybrid Infrastructure

## Guide (execute just on VHI user nodes)

### **Download script.sh**

    wget https://raw.githubusercontent.com/yohrannes/vhi-backup-nodes/main/backup-manager.sh

### **Show last seven snapshots**

- Check your containerid (not nodeid) from admin panel
```
bash backup-manager.sh <CTID>
```
### **Restore snapshots**
```
bash backup-manager.sh <CTID> <BACKUPID [0 - 6]>
```
