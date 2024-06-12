#!/usr/bin/env bash

# Define the cache directory
cache_dir="$XDG_CACHE_HOME/srk_fzf_previewer" 

# Ensure the cache directory exists
mkdir -p "$cache_dir"

# Function to preview the file
preview_file() {
    local file="$1"
    local file_name="$(basename "$file")"
    local cache_file="$cache_dir/${file_name}.jpg"

    case "$(file -b --mime-type "$file")" in 
        "application/pdf")
            if [[ ! -f "$cache_file" ]]; then
                # Convert PDF to PNG
                pdftoppm -jpeg -jpegopt "quality=80,progressive=y,optimize=n" -singlefile -r 50 -scale-to 800 "${file}" "${cache_dir}/${file_name}"
            fi
            # Display the cached image
            kitty icat --clear --transfer-mode=memory --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 "${cache_file}"
            ;;
        "image/png" | "image/jpeg")
            kitty icat --clear --transfer-mode=memory --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 "${file}"
            ;;
        *)
            bat --theme mocha --style=numbers,changes --color=always "$file" | head -200
            ;;
    esac
}

# Check if a file path is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

# Preview the file
preview_file "$1"
