#! /usr/bin/python3

import os
import sys
import subprocess as sp

from slack import notify_deployment

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


if __name__ == "__main__":
    error = deploy()
    if error:
        sys.exit(error)

    error = test()
    if error:
        sys.exit(error)

    error = switch()
    if error:
        sys.exit(error)

    notify_deployment()
