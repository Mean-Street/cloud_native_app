import os
from slackclient import SlackClient

with open(os.path.join(os.environ["CONFIG_DIR"], "slack_token.txt")) as f:
    slack_token = f.read().strip()
sc = SlackClient(slack_token)


def notify_deployment():
    sc.api_call(
      "chat.postMessage",
      channel="#customer",
      text="The application has been upgraded! :tada:"
    )


def notify_test_finished(error):
    sc.api_call(
      "chat.postMessage",
      channel="#dev",
      text=("The Jenkins checks are finished: " + ("SUCCESS :tada:" if not error else "FAILURE :sens_interdit:"))
    )
