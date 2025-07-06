{{- if .Values.ingress.enabled }}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .Values.ingress.externalCert.name | quote }}
  namespace: {{ .Values.namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
spec:
  secretStoreRef:
    kind: ClusterSecretStore
    name: {{ .Values.ingress.externalCert.remoteSecretStore | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: tls.crt
      remoteRef:
        key: {{ .Values.ingress.externalCert.remoteSecretName | quote }}
        property: tls_crt
    - secretKey: tls.key
      remoteRef:
        key: {{ .Values.ingress.externalCert.remoteSecretName | quote }}
        property: tls_key
{{- end }}