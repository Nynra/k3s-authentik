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
    name: {{ .Values.externalSecret.remoteSecretStore | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: postgresql-user-password
      remoteRef:
        key: {{ .Values.externalSecret.remoteSecretName | quote }}
        property: {{ .Values.externalSecret.postgresqlUserPasswordProperty | quote }}
    - secretKey: postgresql-admin-password
      remoteRef:
        key: {{ .Values.externalSecret.remoteSecretName | quote }}
        property: {{ .Values.externalSecret.postgresqlAdminPasswordProperty | quote }}
    - secretKey: authentik-secret-key
      remoteRef:
        key: {{ .Values.externalSecret.remoteSecretName | quote }}
        property: {{ .Values.externalSecret.secretKeyProperty | quote }}
    
