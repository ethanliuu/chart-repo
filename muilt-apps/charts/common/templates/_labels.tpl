{{/* vim: set filetype=mustache: */}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
*/}}
{{- define "common.labels.matchLabels" -}}
app.kubernetes.io/name: {{ .Values.app.name }}
app.kubernetes.io/instance: {{ include "common.names.name" . }}
group: {{ .Values.app.group }}
{{- end -}}

{{/*
Kubernetes standard labels
*/}}
{{- define "common.labels.standard" -}}
helm.sh/chart: {{ include "common.names.chart" . }}
app.kubernetes.io/name: {{ .Values.app.name }}
app.kubernetes.io/instance: {{ include "common.names.name" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
group: {{ .Values.app.group }}
{{- end -}}