## Install Keda

```
helm install \
    keda \
    --repo https://kedacore.github.io/charts \
    keda \
    --namespace keda \
    --create-namespace
```