# Archivedirs

Bash script that archives chosen directories individually from a parent directory and stores them to a target directory
Useful for backing up snapshots of ongoing projects.

## Usage

Form:  archivedirs -s path -t path [DIRECTORIES]

Example:

1. archivedirs -s ~/files -t /mnt/USB/snapshots dir1 project1 bills
2. archivedirs -s /home/user1/files -t /mnt/USB/snapshots project1
3. archivedirs -s /home/user1/files -t /mnt/USB/snapshots *


Result: /mnt/USB/snapshots
    20201201-0930.dir1.tar.gz
    20201201-0930.project1.tar.gz
    20201201-0930.bills.tar.gz
    20201201-0935.project1.tar.gz
    20201201-0940.dir1.tar.gz
    20201201-0940.project1.tar.gz
    20201201-0940.bills.tar.gz


## Example Archive Script

See example.sh for an example backup script.


