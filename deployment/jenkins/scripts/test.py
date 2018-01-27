#! /usr/bin/python3

import os
import sys
import subprocess as sp

from slack import notify_test_finished

DEPLOYMENT_DIR = os.path.realpath(os.path.join(os.path.dirname(os.path.realpath(__file__)), "..", ".."))
OPENSTACK_DIR = os.path.join(DEPLOYMENT_DIR, "openstack")


def deploy():
    os.chdir(OPENSTACK_DIR)
    return sp.call(["./deploy_test.sh"])


def test():
    error = 0
    test_file = os.path.join(DEPLOYMENT_DIR, "..", "tests", "run_tests.py")

    p = sp.Popen(("ssh -o StrictHostKeyChecking=no -i $PRIV_KEY_PATH $SSH_USER@$TEST_FLOATING_IP " +
                  "'python3 -' < " + test_file), shell=True, env=os.environ)

    return p.wait()


def end():
    os.chdir(OPENSTACK_DIR)
    return sp.call(["./end_test.sh"])


if __name__ == "__main__":
    error = deploy()
    if not error:
        error |= test()
    error |= end()

    notify_test_finished(error)

    sys.exit(error)
