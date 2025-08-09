{{ if .Values.enabled }}{{- if .Values.credentials.externalSecret.enabled -}}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: authentik-creds
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
spec:
  secretStoreRef:
    kind: {{ .Values.credentials.externalSecret.storeType | quote }}
    name: {{ .Values.credentials.externalSecret.storeName | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: password
      remoteRef:
        key: {{ .Values.credentials.externalSecret.secretName | quote }}
        property: {{ .Values.credentials.externalSecret.properties.postgresUserPassword | quote }}
    - secretKey: postgres-password
      remoteRef:
        key: {{ .Values.credentials.externalSecret.secretName | quote }}
        property: {{ .Values.credentials.externalSecret.properties.postgresAdminPassword | quote }}
    - secretKey: replication-password
      remoteRef:
        key: {{ .Values.credentials.externalSecret.secretName | quote }}
        property: {{ .Values.credentials.externalSecret.properties.postgresReplicationPassword | quote }}
    - secretKey: secret-key
      remoteRef: 
        key: {{ .Values.credentials.externalSecret.secretName | quote }}
        property: {{ .Values.credentials.externalSecret.properties.authentikSecretKey | quote }}
{{- end }}{{- end }}