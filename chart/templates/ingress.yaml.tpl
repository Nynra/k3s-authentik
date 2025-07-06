{{- if .Values.ingress.enabled }}
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: authentik-ingress
  namespace: {{ .Values.namespace }}
  annotations:
    kubernetes.io/ingress.class: traefik-external
    argocd.argoproj.io/sync-wave: "3"
spec:
  entryPoints:
    - websecure
  routes:
    - match: Host(`{{ .Values.ingress.url }}`)
      kind: Rule
      services:
        - name: authentik
          port: 80
    - match: PathPrefix(`/outpost.goauthentik.io/`)
      kind: Rule
      services:
        - name: authentik
          port: 80
  tls:
    secretName: {{ .Values.ingress.externalCert.name }}
{{- end }}