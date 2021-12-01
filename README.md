# Archive Dirs

A bash script that archives individual directories separately from source path to a target path

# Usage

archdirs -s path -t path [DIRECTORIES]..."
archdirs -s ~/Documents -t /mnt/USB/snapshots awesomeProject bills

### Sample Archive Script

backuprojects.sh

### Man Page

man ./archdirs

# TODO
1. Add array of default excludes in script
2. Add optional argument to ignoring additional dirs
3. Add optional argument for source and target file systems (w/ devices or UUIDS) to perform mounts and umounts
4. Add option for archive types (tar-gzip, zip, 7z)
