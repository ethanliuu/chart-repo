{{/*
Return the proper Docker Image Registry Secret Names
{{ include "common.images.pullSecrets" (dict "list" .Values.image.imagePullSecrets) }}
*/}}
{{- define "common.images.pullSecrets" -}}
imagePullSecrets:
    {{- range .list }}
  - name: {{ . }}
    {{- end -}}
{{- end -}}

{{/*
Return the proper image name
{{ include "common.images.image" ( dict "imageRoot" .Values.path.to.the.image "app" .Values.app) }}
*/}}
{{- define "common.images.image" -}}
{{- $registryName := .imageRoot.registry  -}}
{{- $repositoryName :=  default .app.name }}
{{- $tag := .imageRoot.tag | toString -}}
{{- if $registryName }}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end -}}
{{- end -}}