#!/bin/bash

#
#    Backups/Archives Selected Ongoing Projects On CARGOSHIP to CARGOSHIP snapshots
#


declare -a projects=(
			 "00-main-docs"
			)
#backup_fs=BC41-F11D		# White USB 1 - CARGO SHIP
#backup_fs=7A25B1422820DEAD	# Blue External - BACKUP-DRIVE-A

#source_user=tar
#source_dir_projects=/media/tar/CARGOSHIP/ongoing
#backup_fs_dir_mount=/mnt
#backup_fs_dir_projects=snapshots-recent/1-main-docs-ongoing
#/home/tar/src/0-scripts-misc/archive-dirs-to-mnt.sh -s "${source_dir_projects}" -t "${backup_fs}" -d "${backup_fs_dir_projects}" "${projects[@]}"


source_dir=/media/tar/Cargo/ongoing
target_dir=/media/tar/Cargo/archive-ready/snapshots

/home/tar/src/0-scripts-misc/archive-dirs.sh -s "${source_dir}" -t "${target_dir}" "${projects[@]}"
