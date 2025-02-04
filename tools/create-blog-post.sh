#!/bin/bash

# Prompt user for input filename
read -p "Enter the Post title: " input_title

# Convert to lower case and replace spaces with "-"
input_title=$(echo "$input_title" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

# Get the current date in YYYY-MM-DD format
current_date=$(date +%Y-%m-%d)

# Define the full path to the new file with desired naming convention
new_file_path="../_posts/${current_date}-${input_title}.md"

# Create the new file
touch "$new_file_path"
if [ ! -e "$new_file_path" ]; then
  echo "Failed to create file '$new_file_path'. Exiting."
  exit 1
fi

# Add Jekyll front matter to the file
cat <<EOL > "$new_file_path"
---
layout: post
date: ${current_date}
title: $input_title
description: 
image: /assets/img/bash.jpg
category: linux
tags: []
paginate: true
---
# Write your content here
EOL

echo "File '$new_file_path' has been created with front matter."
