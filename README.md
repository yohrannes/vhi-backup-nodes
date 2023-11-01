# Automatic backup nodes on Virtuozzo Hybrid Infrastructure (shell-command)

Command to be executed on **usernodes**
- Run commands

- Download file
``` $ wget https://raw.githubusercontent.com/yohrannes/vhi-backup-nodes/main/backup-manager.sh; bash backup-manager.sh ```

- Show last seven snapshots
  ``` $ bash backup-manager.sh <CTID> ```

- Restore snapshots
  ``` $ bash backup-manager.sh <CTID> <BACKUPID [0 - 6]> ```
