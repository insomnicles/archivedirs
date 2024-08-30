#!/bin/bash

declare -a dirs=("project" "bills")

source_dir=${HOME}/files
target_dir=${HOME}/backup/snapshots

archivedirs -s "${source_dir}" -t "${target_dir}" "${dirs[@]}"
