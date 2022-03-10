#!/bin/bash

declare -a dirs=("project"
		 "bills")

source_dir=test
target_dir=test/snapshots

./archdirs.sh -s "${source_dir}" -t "${target_dir}" "${dirs[@]}"
