#!/bin/bash

. ./tools.sh

cmd "openstack server delete --wait $TEST_NAME"
