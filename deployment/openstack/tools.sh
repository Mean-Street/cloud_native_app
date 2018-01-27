#!/bin/bash

. ./config.sh

function cmd {
    # In case where we want to read the crude ssh output
    if [ -z "$2" ]; then
        echo $1
    fi
    ssh -o StrictHostKeyChecking=no -i "$CONTROLLER_PRIV_KEY" root@$CONTROLLER_IP ". ./config_files/keystonerc_admin; $1"
}

function cmd_instance {
    # In case where we want to read the crude ssh output
    if [ -z "$3" ]; then
        echo $1
    fi
    ssh -o StrictHostKeyChecking=no -i "$PRIV_KEY_PATH" $SSH_USER@$2 "$1"
}
