#! /usr/bin/python3

if __name__ == "__main__":
    import sys
    import subprocess as sp

    #  error = 0
    #  error |= sp.call(["./tests/b.sh", "http://localhost", "1", "10"])

    # get environment variables and launch tests/run_tests.py on the controller
    config_file = "~/cloud_native_app/deployment/openstack/config.sh"
    test_file = "~/cloud_native_app/tests/run_tests.py"

    res = sp.call([". " + config_file + "; ssh -i $CONTROLLER_PRIV_KEY root@$CONTROLLER_IP python3 " + test_file], shell=True)
    sys.exit(res)
