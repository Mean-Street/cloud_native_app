import os
from slackclient import SlackClient

slack_token = os.environ["SLACK_API_TOKEN"]
sc = SlackClient(slack_token)


def notify_deployment():
    sc.api_call(
      "chat.postMessage",
      channel="#customer",
      text="The application has been upgraded! :tada:"
    )
