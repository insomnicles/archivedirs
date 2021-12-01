#!/bin/bash

declare -a dirs=(
			 "project1"
			 "bills"
			 "workproject"
			 "vacation"
			)

source_dir=/home/user1/Documents
target_dir=/media/user1/USB/snapshots

archive-dirs.sh -s "${source_dir}" -t "${target_dir}" "${dirs[@]}"
