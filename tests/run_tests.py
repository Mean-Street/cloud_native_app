#! /usr/bin/python3

import sys
import requests

SUCCESS_MSG = "PASSED"
FAILURE_MSG = "FAILED"

HOST = "http://localhost:"
PORTS = {
    "i": 8080,
    "s": 8081,
    "b": 8082,
    "p": 8083,
    "w": 8090
}

if __name__ == "__main__":
    error = 0
    for service, port in PORTS.items():
        print("[TEST][SERVICE " + service + "]: ", end="")
        try:
            r = requests.get(HOST + str(port) + "/")
            assert r.status_code // 200 == 1
            assert r.json()["Service"] == "Microservice " + service
            print(SUCCESS_MSG)
        except Exception as e:
            print(FAILURE_MSG)
            print(e)
            error = 1

    sys.exit(error)

# TODO:
# rabbitMQ 15672
# redis 6379
# db 3306 
# web 80

