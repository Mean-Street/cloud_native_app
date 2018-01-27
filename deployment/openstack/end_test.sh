#!/bin/bash

. ./config.sh

cmd "openstack server delete --wait $TEST_NAME"
