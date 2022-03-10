#!/bin/bash

errorMessage()
{
   echo ""
   echo "Usage: $0 -s path -t path [DIRECTORY]..."
   echo -e "\t -s\t\t Directories source path relative to /"
   echo -e "\t -d\t\t Directories target path relative to /"
   echo -e "\t[DIRECTORY]...\t directories (0 or more) from source directories root you want to back up (tar.gz) to target directories root"
   echo ""
   exit 1
}

# Process command-line options
while getopts "s:t:" opt
do
   case "$opt" in
      s) source_dir="$OPTARG" ;;
      t) target_dir="$OPTARG" ;;
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

# print error message if options are missing or empty
if [ -z "$source_dir" ] || [ -z "$target_dir" ]
then
   echo "Missing parameters -s or -t.";
   errorMessage
fi

# if source root directory does not exist, exit
if [ ! -d "${source_dir}" ]; then
    printf "\n\n Error: source directory could not be found.\n"
    exit 1
fi
# if target directory does not exist, exit
if [ ! -d "${target_dir}" ]; then
    printf "\n\n Error: target directory could not be found.\n"
    exit 1
fi

# archive individual directories
for directory in "${directories[@]}"
do
   if [ ! -d "${source_dir}/${directory}" ]; then
   	printf "\nSkipping archive of ${directory}: source directory could not be found in source root directory\n"
   else
        printf "\nArchiving ${directory} Directory. "
        tar czf "${target_dir}/`date +"%Y%m%d-%H%M"`.${directory}".tar.gz \
		--absolute-names \
		--exclude="${source_dir}/${directory}/node_modules" \
		--exclude="${source_dir}/${directory}/vendor" \
		--exclude="${source_dir}/${directory}/database/seeders/explanations" \
		"${source_dir}/${directory}" 1>/dev/null
        printf "Done.\n"
   fi
done

exit 0
