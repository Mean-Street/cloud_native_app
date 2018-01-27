import os
from slackclient import SlackClient

with open(os.path.join(os.environ["CONFIG_DIR"], "slack_token.txt")) as f:
    slack_token = f.read()
sc = SlackClient(slack_token)


def notify_deployment():
    sc.api_call(
      "chat.postMessage",
      channel="#customer",
      text="The application has been upgraded! :tada:"
    )
