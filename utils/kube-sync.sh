#!/bin/bash

FILE_PATH="$(readlink -f "$0")"
REPO_DIR="$(dirname "$FILE_PATH")/../ansible"

cd $REPO_DIR

ansible-playbook -i inventory site.yml --ask-vault-pass $@
