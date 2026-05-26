{{/*
Expand the name of the chart.
*/}}
{{ define "base.name" -}}
{{ .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "base.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "base.labels" -}}
helm.sh/chart: {{ include "base.chart" .context }}
{{ include "base.selectorLabels" (dict "context" .context "component" .component) }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
app.kubernetes.io/part-of: {{ include "base.name" .context }}
{{- if .context.Chart.AppVersion }}
app.kubernetes.io/version: {{ .context.Chart.AppVersion | quote }}
{{- end }}
{{- with .context.Values.commonLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "base.selectorLabels" -}}
app.kubernetes.io/name: {{ include "base.component-fullname" (dict "context" .context "component" .component) }}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end }}
