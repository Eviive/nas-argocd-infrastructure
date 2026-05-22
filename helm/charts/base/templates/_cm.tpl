{{- define "base.cm" }}
{{- $context := .context }}
{{- range .configMaps }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "base.component-fullname" (dict "context" $context "component" .name) }}
  labels:
    {{- include "base.labels" (dict "context" $context "component" .name) | nindent 4 }}
    {{- with .labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  {{- with .annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
data:
  {{- with .literals }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- range $key, $path := .files }}
  {{ $key }}: |-
    {{- $context.Files.Get $path | nindent 4 }}
  {{- end }}
{{- end }}
{{- end }}
