#

https://docs.openshift.com/container-platform/4.15/security/certificates/replacing-default-ingress-certificate.html#replacing-default-ingress_replacing-default-ingress

```
oc create secret tls letsencrypt \
     --cert=okd0.sikademo.com.crt \
     --key=okd0.sikademo.com.key \
     -n openshift-ingress
```

```
oc patch ingresscontroller.operator default \
     --type=merge -p \
     '{"spec":{"defaultCertificate": {"name": "letsencrypt"}}}' \
     -n openshift-ingress-operator
```


----


```
oc create secret tls letsencrypt \
     --cert=.lego/certificates/gpe.sikademo.com.crt \
     --key=.lego/certificates/gpe.sikademo.com.key \
     -n counter-manifests
```

	lego --email ondrejsika@ondrejsika.com --dns cloudflare \
		--domains gpe.sikademo.com \
		--domains '*.gpe.sikademo.com' \
		run
