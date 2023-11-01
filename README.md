# Automatic backup nodes on Virtuozzo Hybrid Infrastructure (shell-command)

## Guide (execute just on VHI user nodes)

- **Download file**

``` $ wget https://raw.githubusercontent.com/yohrannes/vhi-backup-nodes/main/backup-manager.sh ```

- **Show last seven snapshots**

  ``` $ bash backup-manager.sh <CTID> ```

- **Restore snapshots**

  ``` $ bash backup-manager.sh <CTID> <BACKUPID [0 - 6]> ```
