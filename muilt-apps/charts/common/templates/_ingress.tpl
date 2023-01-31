{{/* vim: set filetype=mustache: */}}
{{/*
Return the ingress rules
{{- include "common.ingress.rules" ( dict "ingress" .Values.ingress "global" . )}}
*/}}}
{{- define "common.ingress.rules" -}}
- host: {{ .ingress.hostname | quote }}
  http:
    paths:
      - path: {{ default "/" .ingress.path }}
        pathType: ImplementationSpecific
        backend:
          service:
            name: {{ include "common.names.name" .global }}
            port:
              name: {{ default "http" .ingress.port}}
{{- end -}}
{{- define "common.ingress.extraRules" -}}
{{- $name := (include "common.names.name" .global) -}}
{{- range .list }}
- host: {{ .host |quote }}
  http:
    paths:
      - path: {{ default "/" .path }}
        pathType: ImplementationSpecific
        backend:
          service:
            name: {{ default $name .name }}
            port:
              name: {{ default "http" .port }}
{{- end }}
{{- end -}}