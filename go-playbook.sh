#!/usr/bin/env bash

# Check if the required parameter exists
: ${1?"Usage: $0 PLAYBOOK_FILE.yml"}

# Craft playbook command
PLAYBOOK_COMMAND="ansible-playbook $1"

if [ -n "$SSH_USERNAME" ]; then
  PLAYBOOK_COMMAND+=" -e ansible_user=$SSH_USERNAME"
else
  echo "Info: environment variable SSH_USERNAME not set, using default SSH username (root)"
fi

if [ -n "$SSH_PASSWORD" ]; then
  PLAYBOOK_COMMAND+=" -e ansible_ssh_pass=$SSH_PASSWORD"
  PLAYBOOK_COMMAND+=" -e ansible_become_pass=$SSH_PASSWORD"
elif [ -n "$SSH_KEYPATH" ]; then
  PLAYBOOK_COMMAND+=" --private-key=$SSH_KEYPATH"
else
  echo "Info: environment variables SSH_PASSWORD and SSH_KEYPATH are not set, using default SSH key (~/.ssh/id_rsa) to access servers"
fi

# Get extra command-line parameters
EXTRA_ANSIBLE_VARS="${@:2}"

# install dependency roles
echo "Info: installing dependency roles from Ansible Galaxy"
ansible-galaxy install -p dependent-roles -r requirements.yml

# run playbook
$PLAYBOOK_COMMAND $EXTRA_ANSIBLE_VARS