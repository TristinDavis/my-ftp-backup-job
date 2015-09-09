#!/bin/bash

SAVENAME=$1
FTPUSER=$2
FTPPASS=$3
FTPFOLDER=$4

HOMEDIR=`pwd`
TMPDIR=`mktemp -d`
DOWNLOADSTART=`date --utc +%Y-%m-%d-%H-%M`

cd $TMPDIR
mkdir download
cd download


# -r -l 100          recursion with depth level 100 (0 = inf)
# -t 20              20 tries (standard)
# -np                --no-parent
# -nH                --no-host-directories
# --cut-dirs=2       remove the first two directories
touch hi &&
tar -zcvf ../backup.tar.gz .

SUCCESS=$?
echo $SUCCESS

# Save it in our home
cd $HOMEDIR

if [[ $SUCCESS == "0" ]]; then
	mv $TMPDIR/backup.tar.gz "$1.tar.gz"
	echo $TMPDIR/backup.tar.gz "$1.tar.gz"
	echo `pwd`
fi

rm -rf $TMPDIR
