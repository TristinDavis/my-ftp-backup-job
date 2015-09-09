#!/bin/bash

echo "Prepare to run in cron.."

~/.profile
EXECDIR=`dirname $0`
cd $EXECDIR/daily

echo "Backup will be saved in " `pwd`

echo "Dailybackup started.."

FTPUSER="changeme"
FTPPASS="changeme"
FTPROOT="ftp://change.me"

DOWNLOADSTART=`date --utc +%Y-%m-%d-%H-%M`

echo "Vars set.."
echo "My EXECDIR: $EXECDIR"

$EXECDIR/backup.sh "w.-$DOWNLOADSTART" "$FTPUSER" "$FTPPASS" "$FTPROOT/w.jaller.de/*" > w.log &
$EXECDIR/backup.sh "wiki.-$DOWNLOADSTART" "$FTPUSER" "$FTPPASS" "$FTPROOT/wiki.jaller.de/*" > wiki.log &
$EXECDIR/backup.sh "scriptoverse-$DOWNLOADSTART" "$FTPUSER" "$FTPPASS" "$FTPROOT/scriptoverse/*" > scriptoverse.log

$EXECDIR/postlogs.sh "$FTPUSER" "$FTPPASS" "$FTPROOT/w.jaller.de/data/pages/wiki/"

