#!/bin/bash

BUILD_DIR="$1"
# task_file_path="$2"
task_file_path="task/$(basename "$BUILD_DIR").toml"


tomlq . "$task_file_path" > "$BUILD_DIR/task.json"

node src/combine-glyphs-kerning.js "$BUILD_DIR"
