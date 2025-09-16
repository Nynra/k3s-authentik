{{- if .Values.enabled }}{{- if .Values.ingress.cert.reflectedSecret.enabled }}
---
apiVersion: v1
kind: Secret
metadata:
  name: authentik-tls
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
    reflector.v1.k8s.emberstack.com/reflects: "{{ .Values.ingress.cert.reflectedSecret.originNamespace }}/{{ .Values.ingress.cert.reflectedSecret.originSecretName }}"
---
apiVersion: v1
kind: Secret
metadata:
  name: authentik-outpost-tls
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
    reflector.v1.k8s.emberstack.com/reflects: "{{ .Values.ingress.cert.reflectedSecret.originNamespace }}/{{ .Values.ingress.cert.reflectedSecret.originSecretName }}"
---
{{ end }}{{ end }}