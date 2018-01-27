#!/bin/bash

. ./config.sh

cmd "openstack server delete -y $TEST_NAME"
