# Caches

#### Notes

- Organization wide
- Every customer has up to <N> Gigabytes reserved, he can buy more if necessary
- Cache takes up takes up part of this reserved space
- A job can use multiple caches

#### Examples

``` yaml
apiVersion: v1
kind: Cache
metadata:
  name: "job-page-cache"                                # Required.
  id: "f67f6e8b-0bbf-4e7e-b41e-da41ee9c6885"            # Populated by the API.
spec:
  capacity: 1Gi                                         # Required. Every customer has a limited total capacity for all caches.
  evictionPolicy:
    strategy: LRU
status:                                                 # Populated by the API.
  ready: true
  access:
    username: "f67f6e8b-0bbf-4e7e-b41e-da41ee9c6885"
    password: "312312331231-afsdfadsfas-f67f6e8b-0bbf-4e7e-b41e"
    host: "caches.h32.semaphoreci.com"
    port: 30042
```

``` yaml
apiVersion: v1
kind: Cache
metadata:
  name: "mix-cache"                                     # Required.
  id: "f67f6e8b-0bbf-4e7e-b41e-da41ee9c6885"            # Populated by the API.
spec:
  capacity: 1Gi                                         # Required. Every customer has a limited total capacity for all caches.
  evictionPolicy:
    strategy: LRU
status:                                                 # Populated by the API.
  ready: true
  access:
    username: "f67f6e8b-0bbf-4e7e-b41e-da41ee9c6885"
    password: "312312331231-afsdfadsfas-f67f6e8b-0bbf-4e7e-b41e"
    host: "caches.h32.semaphoreci.com"
    port: 30042
```
