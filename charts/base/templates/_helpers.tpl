{{/*
Create component name and version as used by the chart label.
*/}}
{{- define "base.component-fullname" -}}
{{- printf "%s-%s" (include "base.name" .context) (.component | default "") | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*

*/}}
{{- define "base.container" -}}
- name: {{ .container.name }}
  image: "{{ .container.image.repository }}:{{ .container.image.tag }}"
  {{- with .container.command }}
  command:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .container.args }}
  args:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .container.restartPolicy }}
  restartPolicy: {{ . }}
  {{- end }}
  {{- with .container.lifecycle }}
  lifecycle:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .container.env }}
  env:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .container.envFrom }}
  envFrom:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .container.ports }}
  ports:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .container.livenessProbe }}
  livenessProbe:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .container.readinessProbe }}
  readinessProbe:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .container.securityContext }}
  securityContext:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .container.resources }}
  resources:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .container.volumeMounts }}
  volumeMounts:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
