#!/bin/bash
# internsctl script

VERSION="1.0.1"

function file_info {
  if [ -z "$2" ]; then
    echo "Usage: $0 file getinfo [options] <file name>"
    exit 1
  fi

  filename="$2"

  if [ -e "$filename" ]; then
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --size | -s)
          echo "Size: $(stat -c %s "$filename") bytes"
          ;;
        --permissions | -p)
          echo "Permissions: $(stat -c %a "$filename")"
          ;;
        --owner | -o)
          echo "Owner: $(stat -c %U "$filename")"
          ;;
        --last-modified | -m)
          echo "Last Modified: $(stat -c %y "$filename")"
          ;;
        *)
          echo "Unknown option: $1"
          exit 1
          ;;
      esac
      shift
    done
  else
    echo "File not found: $filename"
    exit 1
  fi
}

function show_version {
  echo "internsctl version $VERSION"
}

# Check for the subcommand or options and execute the corresponding function
case "$1" in
  "file")
    shift
    case "$1" in
      "getinfo")
        shift
        file_info "$@"
        ;;
      *)
        echo "Unknown file subcommand: $1"
        exit 1
        ;;
    esac
    ;;
  "--version")
    show_version
    ;;
  *)
    echo "Usage: $0 {file|--version}"
    exit 1
    ;;
esac
