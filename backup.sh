#!/bin/bash

echo "Backup started.."

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

echo "Start download: " `date --utc`

# -r -l 100          recursion with depth level 100 (0 = inf)
# -t 20              20 tries (standard)
# -np                --no-parent
# -nH                --no-host-directories
# --cut-dirs=2       remove the first two directories
wget -r -l inf -t 20 -np -nH --cut-dirs=1 \
	--user="$2" --password="$3" "$4"

DOWNSUCCESS=$?

if (( $DOWNSUCCESS -ne 0 )); then
	echo "Download failed.. " `date --utc`
	echo "Starting cleanup.."
	cd
	rm -rf $TMPDIR
	echo "Cleanup finished!"
	echo "Terminating.."
fi

echo "Finished downloading: " `date --utc`
echo "Started packing.."

tar -zcf ../backup.tar.gz .

echo "Finished packing: " `date --utc`
echo "Success: $DOWNSUCCESS"

# Save it in our home
cd $HOMEDIR

if [[ $DOWNSUCCESS == "0" ]]; then
	mv $TMPDIR/backup.tar.gz "$1.tar.gz"
fi

rm -rf $TMPDIR

echo "Backup ended"

