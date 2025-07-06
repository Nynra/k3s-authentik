# app-1password-connect.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: authentik-app
  namespace: {{ .Values.argocdNamespace | quote }}
  annotations: 
    argocd.argoproj.io/sync-wave: "2"
spec:
  destination:
    namespace: {{ .Values.namespace | quote }} 
    server: {{ .Values.kubernetesApiServer | quote }}
  project: {{ .Values.argocdProject | quote }}
  sources:
    - repoURL: "https://charts.goauthentik.io" 
      targetRevision: {{ .Values.authentikTargetRevision | quote }}
      chart: authentik
      helm:
        values: |- 
          global:
            env:
              # Database secrets
              - name: AUTHENTIC_POSTGRESQL__PASSWORD
                valueFrom:
                  secretKeyRef:
                    name: authentik-secret
                    key: postgresql-user-password
              - name: AUTHENTIK_SECRET_KEY
                valueFrom:
                  secretKeyRef:
                    name: authentik-secret
                    key: authentik-secret-key
              # Email secrets
              - name: AUTHENTIK_EMAIL_USERNAME
                valueFrom:
                  secretKeyRef:
                    name: smtp-secret
                    key: smtp-username
              - name: AUTHENTIK_EMAIL_PASSWORD
                valueFrom:
                  secretKeyRef:
                    name: smtp-secret
                    key: smtp-password
              # Some user settings
              - name: AUTHENTIK_DEFAULT_USER_CHANGE_NAME
                value: {{ .Values.defaultUserChangeName | quote }}
              - name: AUTHENTIK_DEFAULT_USER_CHANGE_EMAIL
                value: {{ .Values.defaultUserChangeEmail | quote }}
              - name: AUTHENTIK_DEFAULT_USER_CHANGE_USERNAME
                value: {{ .Values.defaultUserChangeUsername | quote }}
              - name: AUTHENTIK_GDPR_COMPLIANCE
                value: {{ .Values.gdprCompliance | quote }} 

          authentik:
            error_reporting:
              enabled: false

          server:
            ingress:
              enabled: false
              # ingressClassName: TraefikIngress
              # hosts:
              #   - authentik.domain.tld

          postgresql:
            enabled: true
            existingSecret: authentik-secret
            secretKeys:
              adminPasswordKey: postgresql-admin-password
              userPasswordKey: postgresql-user-password

          redis:
              enabled: true
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
