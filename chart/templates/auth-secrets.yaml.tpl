apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: authentik-secret
  namespace: {{ .Values.namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
spec:
  secretStoreRef:
    kind: ClusterSecretStore
    name: {{ .Values.externalAuthSecret.remoteSecretStore | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: postgresql-user-password
      remoteRef:
        key: {{ .Values.externalAuthSecret.remoteSecretName | quote }}
        property: {{ .Values.externalAuthSecret.postgresqlUserPasswordProperty | quote }}
    - secretKey: postgresql-admin-password
      remoteRef:
        key: {{ .Values.externalAuthSecret.remoteSecretName | quote }}
        property: {{ .Values.externalAuthSecret.postgresqlAdminPasswordProperty | quote }}
    - secretKey: authentik-secret-key
      remoteRef:
        key: {{ .Values.externalAuthSecret.remoteSecretName | quote }}
        property: {{ .Values.externalAuthSecret.authentikSecretKeyProperty | quote }}

