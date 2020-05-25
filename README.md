"# rclone_backup_shell" 

创建service

    cat <<EOF >/usr/lib/systemd/system/bitwarden.service 
    [Unit]
    Description=bitwarden backup service
     
    [Service]
    Type=simple
    ExecStart=/file/sh/bitwarden_backup.sh
     
    [Install]
    WantedBy=multi-user.target
    EOF
    
systemctl start bitwarden

    cat <<EOF > /usr/lib/systemd/system/bitwarden.timer
    [Unit]
    Description=bitwarden backup task
     
    [Timer]
    OnUnitActiveSec=10m
    Unit=bitwarden
     
    [Install]
    WantedBy=timers.target
    EOF
    
    cat <<EOF > /usr/lib/systemd/system/bitwarden.timer
    [Unit]
    Description=Run foo weekly and on boot
     
    [Timer]
    OnBootSec=3min
    OnUnitActiveSec=9h
     
    [Install]
    WantedBy=timers.target
    EOF


systemctl daemon-reload

systemctl  start  bitwarden.timer


systemctl  start  bitwarden.timer
# 启动定时任务
systemctl  stop  bitwarden.timer
# 暂停定时任务
systemctl  status  bitwarden.timer

