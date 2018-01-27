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
    print("TODO: run tests")
    # TODO
    #  error |= sp.call(["./tests/b.sh", "http://localhost", "1", "10"])

    # get environment variables and launch tests/run_tests.py on the controller
    #config_file = "~/cloud_native_app/deployment/openstack/config.sh"
    #test_file = "~/cloud_native_app/tests/run_tests.py"

    #res = sp.call([". " + config_file + "; ssh -i $CONTROLLER_PRIV_KEY root@$CONTROLLER_IP python3 " + test_file], shell=True)

    return error


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
