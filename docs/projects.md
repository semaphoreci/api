# Project

#### Notes

- Organization wide

#### Examples

``` yaml
apiVersion: v1
kind: Project
metadata:
  name: "job-page"

spec:
  repository:
    url: git@github.com:renderedtext/job_page.git
    apiToken: shiroyasha

  branches:
    default: master

    blacklist:
      - "/staging/"

    priority:
      - "/master/"

    cancellationStrategy: all
    stoppingStrategy: non-default

  cron:
    - name: "Hourly Builds"
      schedule: "*/0 * * * *"
      branch: "master"

status:
  repository:
    connected: true
    deploy:
      name: semaphore-renderedtext-job_page
      fingerprint: 39:b6:3f:b0:8d:90:db:ed:65:95:61:15:2c:51:b5:24
    webhook: https://semaphoreci.com/github_hook?hash_id=eab6c636-8fb5-410a-8823-47dcf9e2a382
```
