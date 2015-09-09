#!/bin/bash

FTPUSER=$1
FTPPASS=$2
FTPFOLDER=$3

{
	echo -e "====== Backup Logs ======\n\n===== Logs =====\n<file - w.log>";
	cat w.log;
	echo -e "</file>\n\n<file - wiki.log>";
	cat wiki.log;
	echo -e "</file>\n\n<file - scriptoverse.log>";
	cat scriptoverse.log;
	echo -e "</file>";
} > backuplogs.txt
wait

curl -T backuplogs.txt "$FTPFOLDER" --user "$FTPUSER:$FTPPASS"

