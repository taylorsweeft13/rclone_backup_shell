#!/bin/bash

# 定义GOOGLE DRIVE的备份目录
GD_PATH="gdrive:sync/bitwarden"

# 定义备份的目录及文件，不同的目录用空格分开
BACKUP_SRC="/tmp/db.sqlite3"

# 定义临时文件存放目录
BACKUP_DST="/tmp"

# 定义文件前缀名
#NOW=$(date +"%Y.%m.%d")
NOW=$(date "+%F-%H:%M:%S")
#OLD=$(date -d -10day +"%Y.%m.%d")

# 定义备份文件的存储路径及文件名
DESTFILE="$BACKUP_DST/$NOW.zip"

# use sqlite3 to create backup (avoids corruption if db write in progress)
sqlite3 /file/bw-data/db.sqlite3 ".backup '/tmp/db.sqlite3'"

# 压缩加密
zip -rP change_your_password_here $DESTFILE  $BACKUP_SRC

# 使用rclone上传到google drive
rclone copy $DESTFILE $GD_PATH

# 删除本地的临时文件
rm -f $DESTFILE $BACKUP_SRC

# 删除10天前的备份
#rclone delete $GD_PATH/$OLD.tar.gz