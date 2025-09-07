# k3s-authentik

on initial setup

```bash
sudo kubectl port-forward svc/ak-outpost-authentik-embedded-outpost -n authentik 8080:9000
 --address 0.0.0.0
```

navigate to

```
http://<your server's IP or hostname>:9000/if/flow/initial-setup/
```
