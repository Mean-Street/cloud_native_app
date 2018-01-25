#!/bin/sh

IP=$1
KEY_PAIR=$2

. ./config.sh

ssh -i $KEY_PAIR $SSH_USER@$IP ls
ssh -i $KEY_PAIR $SSH_USER@$IP touch test
ssh -i $KEY_PAIR $SSH_USER@$IP ls
ssh -i $KEY_PAIR $SSH_USER@$IP rm test
ssh -i $KEY_PAIR $SSH_USER@$IP ls
