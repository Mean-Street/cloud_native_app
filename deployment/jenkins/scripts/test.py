#! /usr/bin/python3

import os
import sys
import time
import subprocess as sp

from slack import notify_end_test, notify_start_test

DEPLOYMENT_DIR = os.path.realpath(os.path.join(os.path.dirname(os.path.realpath(__file__)), "..", ".."))
OPENSTACK_DIR = os.path.join(DEPLOYMENT_DIR, "openstack")
SERVICES_START_DELAY = 20


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
    notify_start_test()

    error = deploy()
    if not error:
        print("Wait {0}s for services to start".format(SERVICES_START_DELAY))
        time.sleep(SERVICES_START_DELAY)
        error |= test()
    error |= end()

    notify_end_test(error)

    sys.exit(error)
