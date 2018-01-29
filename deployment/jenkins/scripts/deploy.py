#! /usr/bin/python3

import os
import sys
import subprocess as sp
import requests

from slack import notify_deployment, notify_deployment_error

DEPLOYMENT_DIR = os.path.realpath(os.path.join(os.path.dirname(os.path.realpath(__file__)), "..", ".."))
OPENSTACK_DIR = os.path.join(DEPLOYMENT_DIR, "openstack")


def deploy():
    os.chdir(OPENSTACK_DIR)
    return sp.call(["./deploy_prod.sh"])


def test():
    error = 0
    try:
        r = requests.get("http://" + os.environ["PROD_FLOATING_IP"])
        assert r.status_code // 200 == 1
    except Exception as e:
        print("ERROR:", e)
        error = 1
    return error


def switch():
    os.chdir(OPENSTACK_DIR)
    return sp.call(["./switch_prod.sh"])


def error():
    notify_deployment_error()
    sys.exit(1)


if __name__ == "__main__":
    # TODO: avoid duplicates old_prod instances (for instance, when the tests failed)

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
