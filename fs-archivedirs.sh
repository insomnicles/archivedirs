#!/bin/bash

#
#	Archive (tar.gz) specific directories from a source directory to a target filesystem
#
#

# 	TODO:
#	1. Change to relative path inside archive.tar.gz 
#	2. exclude database/seeders/explanations
#	2. Add optional -sfs UUID parameter to allow backups relative to source FS
#	3. change target filesystem option to device (/dev/sda1)
#	4. remove ignore node_modules, vendors dir; add option for ignoring specific directories
#

errorMessage()
{
   echo ""
   echo "Usage: $0 -s path -t uuid -d path [DIRECTORY]..."
   echo -e "\t -s\t\t Directories root path relative to /"
   echo -e "\t -t\t\t Target Filesystem UUID"
   echo -e "\t -d\t\t Directories root path relative to target filesystem /"
   echo -e "\t[DIRECTORY]...\t directories (0 or more) from source directories root you want to back up (tar.gz) to target directories root"
   echo ""
   exit 1
}

# Process command-line options
while getopts "s:t:d:" opt
do
   case "$opt" in
      s) source_dir="$OPTARG" ;;
      t) backup_fs_uuid="$OPTARG" ;;
      d) backup_fs_dir="$OPTARG" ;;
      ? ) errorMessage ;;
   esac
done

# Process arguments
directories=()
shift $(( OPTIND - 1 ))
for dir in "$@";
do
   directories+=("${dir}")
done

# Print error message if options are missing or empty
if [ -z "$source_dir" ] || [ -z "$backup_fs_uuid" ] || [ -z "$backup_fs_dir" ]
then
   echo "Missing parameters -s -tfs or -tdr.";
   errorMessage
fi

# if source root directory does not exist, exit
if [ ! -d "${source_dir}" ]; then
    printf "\n\n Error: source root directory could not be found.\n"
    exit 1
fi


#  Mount Backup Filesystem
printf "\nMounting Backup FS ..."
backup_fs_dir_mount="/mnt/${backup_fs_uuid}"
backup_dir="${backup_fs_dir_mount}/${backup_fs_dir}"
source_dir="${source_dir}"

umount "${backup_fs_dir_mount}"

# if mount directory for filesystem does not exist, create it
if [ ! -d "${backup_fs_dir_mount}" ]; then
    mkdir "${backup_fs_dir_mount}"
    status=$?
    if [ "${status}" -ne 0 ]; then
	printf "${status}"

	printf "\n\n Error: fs could not be mounted.\n"
	exit 0
    fi
fi

mount --uuid="${backup_fs_uuid}" "${backup_fs_dir_mount}"
ret=$?
if [ "${ret}" -ne 0 ]; then
    printf "\n\n Error: FS could not be mounted.\n"
    exit 1
fi
printf "Done.\n"

# if target root directory does not exist, exit
if [ ! -d "${backup_dir}" ]; then
    printf "\n\n Error: root directory on target fs could not be found.\n"
    exit 1
fi

# Backup Directories
for directory in "${directories[@]}"
do
   if [ ! -d "${source_dir}/${directory}" ]; then
   	printf "\nSkipping archive of ${directory}: source directory could not be found in source root directory\n"
   else
        printf "\nArchiving ${directory} Directory. "
        tar czf "${backup_dir}/`date +"%Y%m%d-%H%M"`.${directory}".tar.gz \
		--absolute-names \
		--exclude="${source_dir}/${directory}/node_modules" \
		--exclude="${source_dir}/${directory}/vendor" \
		--exclude="${source_dir}/${directory}/database/seeders/explanations" \
		"${source_dir}/${directory}" 1>/dev/null
        printf "Done.\n"
#		--absolute-names \

   fi
done

# Unmount Backup Filesystem
printf "\nUnmounting Backup FS..."
sleep 1
umount "${backup_fs_dir_mount}/${backup_fs}"
printf "Done.\n"

exit 0
