#!/bin/bash

function _die() {
    echo "$2" > /dev/stderr
    exit "$1"
}

[[ -z "$1" ]] && _die 1 "[FATAL] Must specify a task by TOML file path!"
[[ ! -e "$1" ]] && _die 1 "[FATAL] Task not found!"

task_file_path="$1"
task_id="$(basename "$task_file_path" | sed s/.toml$//)"
echo "Working on $task_file_path ($task_id)"

export BUILD_DIR="build/$task_id"
mkdir -p "$BUILD_DIR"/{svgraw,svgoutline,misc}

# find "$BUILD_DIR" -type f -delete     ### Purge build directory




tomlq . "$task_file_path" > "$BUILD_DIR/task.json"

map_file_src="assets/$(tomlq -r .tanefont_task.map "$task_file_path").toml"

tomlq -r . "$map_file_src" > "$BUILD_DIR/map.json"


export svg_outline_convert_bin_path="$(which svg-text-to-outline.sh)"
node src/make-svg-raw.js


### TODO: Use inkscape to convert to outline
### TODO: Use imagemagick to get filled width
### TODO: Generate final width map
### TODO: (Optional) Generate selective kerning map???
