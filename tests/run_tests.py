#! /usr/bin/python3

import sys
import requests
import random

RED = '\033[31m'
GREEN = '\033[32m'
END_COLOR = '\033[0m'
success = GREEN + "PASSED" + END_COLOR
failure = RED + "FAILED" + END_COLOR


host = "http://localhost:"
services = {
"i":8080,
"s":8081,
"b":8082,
"p":8083,
"w":8090
}


error = 0
for service, port in services.items():
    print("[TEST][SERVICE " + service + "]: ", end="")
    try:
        response = request.get(host + port + "/").json()
        assert(response["Service"] == "Microservice " + service)
        print(success)
    except:
        print(failure)
        error = 1

sys.exit(error)

# TODO:
# rabbitMQ 15672
# redis 6379
# db 3306 
# web 80

