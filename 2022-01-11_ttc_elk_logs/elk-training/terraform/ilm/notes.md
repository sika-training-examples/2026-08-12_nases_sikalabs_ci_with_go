Set `indices.lifecycle.poll_interval`

```
PUT _cluster/settings
{
  "persistent": {
    "indices.lifecycle.poll_interval": "5s"
  }
}
```
