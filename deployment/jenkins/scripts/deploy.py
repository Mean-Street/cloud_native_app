#! /usr/bin/python3

import os
import sys
import subprocess as sp

from slack import notify_deployment, notify_deployment_error

DEPLOYMENT_DIR = os.path.realpath(os.path.join(os.path.dirname(os.path.realpath(__file__)), "..", ".."))
OPENSTACK_DIR = os.path.join(DEPLOYMENT_DIR, "openstack")


def deploy():
    os.chdir(OPENSTACK_DIR)
    return sp.call(["./deploy_prod.sh"])


def test():
    error = 0
    print("TODO: make sure the app is deployed")
    return error


def switch():
    os.chdir(OPENSTACK_DIR)
    return sp.call(["./switch_prod.sh"])


def error():
    notify_deployment_error()
    sys.exit(1)


if __name__ == "__main__":
    err = deploy()
    if err:
        error()

    err = test()
    if err:
        error()

    err = switch()
    if err:
        error()

    notify_deployment()
