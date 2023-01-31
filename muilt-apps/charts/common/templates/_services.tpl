{{/* vim: set filetype=mustache: */}}
{{/*
Return the services.ports
{{- include "common.services.ports" (dict "list" .Values.service)}}
*/}}
{{- define "common.services.ports" -}}
{{- range .list }}
- name: {{ .name }}
  port: {{ .port }}
  targetPort: {{ .name }}
  protocol: {{ default "TCP" .protocol }}
{{- end -}}
{{- end -}}