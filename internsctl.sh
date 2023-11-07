#!/bin/bash
# internsctl script

VERSION="1.0.1"

function internsctl-cpu {
  # Add your CPU information retrieval logic here
  lscpu
}

function create_user {
  if [ -z "$2" ]; then
    echo "Usage: $0 user create <username>"
    exit 1
  fi

  username="$2"

  # Add your user creation logic here
  # Example: sudo adduser "$username"
  echo "User $username created successfully"
}

function list_users {
  # Add your user listing logic here
  # Example: getent passwd
  echo "List of users:"
  getent passwd | cut -d: -f1
}

function file_info {
  if [ -z "$2" ]; then
    echo "Usage: $0 file getinfo <file name>"
    exit 1
  fi

  filename="$2"

  if [ -e "$filename" ]; then
    echo "file :- $filename"
    echo "Access :- $(stat -c %a "$filename")"
    echo "Size :- $(stat -c %s "$filename") bytes"
    echo "Owner :- $(stat -c %U "$filename")"
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
  "cpu")
    shift
    case "$1" in
      "getinfo")
        internsctl-cpu
        ;;
      *)
        echo "Unknown cpu subcommand: $1"
        exit 1
        ;;
    esac
    ;;
  "user")
    shift
    case "$1" in
      "create")
        create_user "$@"
        ;;
      "list")
        list_users
        ;;
      *)
        echo "Unknown user command: $1"
        exit 1
        ;;
    esac
    ;;
  "file")
    shift
    case "$1" in
      "getinfo")
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
    echo "Usage: $0 {cpu|user|file|--version}"
    exit 1
    ;;
esac
