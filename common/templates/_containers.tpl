{{/*
Return deploy.spec.template.spec.containers.ports
{{- include "common.containers.ports" (dict "list" .Values.service) | nindent 10 }}
*/}}
{{- define "common.containers.ports" -}}
{{- range .list }}
- name: {{ .name }}
  containerPort: {{ default .port .target }}
  protocol: {{ default "TCP" .protocol }}
{{- end }}
{{- end -}}

{{/*
Return the default env
*/}}
{{- define "common.containers.defaultEnv" -}}
- name: NAMESPACE
  valueFrom:
    fieldRef:
      fieldPath: metadata.namespace
- name: NODE_IP
  valueFrom:
    fieldRef:
      fieldPath: status.hostIP
{{- end -}}

{{- define  "common.containers.env" -}}
{{ range .list }}
- name: {{ .name }}
  value: {{ .value | quote}}
{{ end }}
{{- end -}}

{{- define "common.containers.envFrom" -}}
{{- $secretName := printf "%s-secret" (include "common.names.name" .global)  -}}
{{- $configMapName := printf "%s-conf" (include "common.names.name" .global)  -}}
{{- range .list }}
{{- if eq .type "configMap" }}
- configMapRef:
    name: {{ default $configMapName .name }}
{{- else if eq .type "secret" }}
- secretRef:
    name: {{ default $secretName .name }}
{{- end }}
{{- end }}
{{- end -}}

{{- define "common.containers.configMap" -}}
{{- $name := printf "%s-conf" (include "common.names.name" .global) -}}
  {{- range  .config }}
- name: {{ default $name .name }}
  mountPath: {{ .path }}
  subPath: {{ .key }}
  readOnly: true
  {{- end }}
{{- end -}}

{{/*
Return the configMap of deploy.spec.template.volumes
{{- include "common.volumes.configMap" ( dict "config" .Values.configMap "values" . ) }}
*/}}
{{- define "common.volumes.configMap" -}}
{{- $name := printf "%s-conf" (include "common.names.name" .global) -}}
  {{- range  .config }}
- name: {{ default $name .name }}
  configMap:
    name: {{ default $name .name }}
    items:
    - key: {{ .key }}
      path: {{ .key }}
  {{- end }}
{{- end -}}

{{- define "common.template.annotations" -}}
kubectl.kubernetes.io/restartedAt: {{ now | date "2006-01-02T15:04:05Z" }}
{{- end -}}