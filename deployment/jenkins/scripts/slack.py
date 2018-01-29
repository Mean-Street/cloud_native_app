import os
from slackclient import SlackClient

with open(os.path.join(os.environ["CONFIG_DIR"], "slack_token.txt")) as f:
    slack_token = f.read().strip()
sc = SlackClient(slack_token)


def notify_deployment():
    sc.api_call(
        "chat.postMessage",
        channel="#customer",
        text="The application has been upgraded! Find it at http://{0}! :tada: :tada: :tada:".format(os.environ["PROD_FLOATING_IP"])
    )


def notify_deployment_error():
    sc.api_call(
        "chat.postMessage",
        channel="#dev",
        text=":no_entry: :no_entry: :no_entry: Error deploying the application! :no_entry: :no_entry: :no_entry:"
    )


def notify_start_deployment():
    sc.api_call(
        "chat.postMessage",
        channel="#dev",
        text="Push detected on master. The application is being deployed... :rocket:"
    )


def notify_start_test():
    sc.api_call(
        "chat.postMessage",
        channel="#dev",
        text="Push detected on dev. The application is being tested... :zzz:"
    )


def notify_end_test(error):
    if error:
        msg = ":no_entry: Dev branch has been tested: FAILURE :no_entry:"
    else:
        msg = ":tada: Dev branch has been tested: SUCCESS :tada:"
    sc.api_call(
        "chat.postMessage",
        channel="#dev",
        text=msg
    )
