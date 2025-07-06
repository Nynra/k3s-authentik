apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: smtp-secret
  namespace: {{ .Values.namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
spec:
  secretStoreRef:
    kind: ClusterSecretStore
    name: {{ .Values.externalSmtpSecret.remoteSecretStore | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: smtp-username
      remoteRef:
        key: {{ .Values.externalSmtpSecret.remoteSecretName | quote }}
        property: {{ .Values.externalSmtpSecret.smtpUsernameProperty | quote }}
    - secretKey: smtp-password
      remoteRef:
        key: {{ .Values.externalSmtpSecret.remoteSecretName | quote }}
        property: {{ .Values.externalSmtpSecret.smtpPasswordProperty | quote }}
