# archivedir

A bash script that archives individual directories separately from source path to a target path

# Usage

archivedirs -s path -t path [DIRECTORY]..."
archivedirs -s ~/Documents -t /mnt/USB/snapshots awesomeProject bills

# Sample Archive Script

archivemeprojects.sh

# 	TODO
1. Add array of default excludes in script
2. Add optional argument to ignoring additional dirs
3. Add optional argument for source and target file systems (w/ devices or UUIDS) to perform mounts and umounts