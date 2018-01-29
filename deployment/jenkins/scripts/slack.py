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
        text="The deployment has just started! :rocket:"
    )


def notify_start_test():
    sc.api_call(
        "chat.postMessage",
        channel="#dev",
        text="The application is being tested... :zzz:"
    )


def notify_end_test(error):
    if error:
        msg = ":no_entry: Jenkins checks response: FAILURE :no_entry:"
    else:
        msg = ":tada: Jenkins checks response: SUCCESS :tada:"
    sc.api_call(
        "chat.postMessage",
        channel="#dev",
        text=msg
    )
