#!/bin/sh
set -o errexit

stdout() { echo "$(date "+%Y.%m.%d %H:%M:%S.%3N:") INFO : $1" ; }

finish() {
        res=$?
	if [ 0 -ne $res ]; then
                stdout "ERROR: script did not exit successfully. Exit code $res"
        fi
}
trap finish EXIT

if [ ! $1 ]
        then
        stdout  "Missing parameters: hdb directory. Exiting"
        exit 1
fi

if [ ! -d $1 ]
        then
        stdout "$1 is not a directory. Exiting"
        exit 1
fi

export BAK_DIR=`date +%F-%H-%M-%S`
stdout "Backing up HDB tables prior to maintenance"
stdout "HDB Directory: ${1}"
stdout "Backup Directory: `dirname ${1}`"

if [ ! -d `dirname ${1}`/hdbdir_bak ]
then
	stdout "Creating backup directory"
	mkdir -p `dirname ${1}`/hdbdir_bak
fi

stdout "Creating hdbdir_bak/$BAK_DIR"
mkdir -p `dirname ${1}`/hdbdir_bak/$BAK_DIR

cp -r --parents $1/* `dirname ${1}`/hdbdir_bak/$BAK_DIR
stdout "Backup complete"

taskset -c 0 q /home/dcrossey/script-demo/dbmaint.q -database `readlink -f $1` <<< '\l hdbmaint.q'

exit 0
