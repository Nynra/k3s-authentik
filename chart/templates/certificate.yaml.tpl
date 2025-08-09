{{- if .Values.ingress.enabled }}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: authentik-tls-secret
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-5"
spec:
  secretStoreRef:
    kind: {{ .Values.ingress.externalCert.storeType | quote }}
    name: {{ .Values.ingress.externalCert.storeName | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: tls.crt
      remoteRef:
        key: {{ .Values.ingress.externalCert.secretName | quote }}
        property: tls_crt
    - secretKey: tls.key
      remoteRef:
        key: {{ .Values.ingress.externalCert.secretName | quote }}
        property: tls_key
{{- end }}