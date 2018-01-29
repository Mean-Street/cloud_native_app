#!/bin/bash

set -e

. ./tools.sh

echo "Get private key"
rm -f $PRIV_KEY_PATH
cmd "openstack stack output show -f value $STACK_NAME ssh_key" false > priv.tmp
tail -n +3 priv.tmp > $PRIV_KEY_PATH
rm priv.tmp
chmod 400 $PRIV_KEY_PATH
