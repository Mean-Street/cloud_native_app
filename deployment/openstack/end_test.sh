#!/bin/bash

set -e

. ./tools.sh

cmd "openstack server delete --wait $TEST_NAME"
