{{- if .Values.ingress.enabled }}{{- if .Values.ingress.cert.externalCert.enabled }}
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: authentik-tls
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "2"
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
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: authentik-outpost-tls
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "2"
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
{{- end }}{{ end }}