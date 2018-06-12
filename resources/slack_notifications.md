# Slack Notification

#### Notes

- Organization wide

#### Examples

``` yaml
apiVersion: v1
kind: SlackNotification
metadata:
  name: "eng-notification"
spec:
  webhook: dsfasdfasdf@slack.com/webhooks/2313123-12312
  channel: "#engineering"
  avatar: ":semaphore:"
```
