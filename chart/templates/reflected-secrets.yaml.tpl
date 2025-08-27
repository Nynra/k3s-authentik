{{ if .Values.enabled }}{{- if .Values.credentials.reflectedSecret.enabled }}
---
apiVersion: v1
kind: Secret
metadata:
  name: authentik-creds
  annotations:
    reflector.v1.k8s.emberstack.com/reflects: "{{ .Values.credentials.reflectedSecret.originNamespace }}/{{ .Values.credentials.reflectedSecret.originSecretName }}"
    argo-cd.argoproj.io/sync-wave: "1"
{{- end }}{{- end }}
