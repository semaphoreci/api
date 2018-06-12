# Github Repository

- Assumption: When the resource is created, we add a deploy key to github and change the status to connected
- What happens when the resource is deleted? Cleanup?
- What does this resource represents? Only the connection, or is it a notification too?

```
apiVersion: v1
kind: GitHubRepository
metadata:
  name: "job-page"
spec:
  github-user: darkofabijan
  endpoint: "https://github.com/renderedtext/job-page"
status:
  connected: true
```

# Cron

- How cron triggers something?
- Is it project or organization wide?
- Should this be part of the project resource instead?

```
apiVersion: v1
kind: Cron
metadata:
  name: hourly-builds
spec:
  schedule: "*/0 * * * *"
```
