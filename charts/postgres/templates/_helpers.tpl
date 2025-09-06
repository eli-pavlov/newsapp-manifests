{{- define "postgres.name" -}}
{{- if .Values.service.name -}}
{{ .Values.service.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{ .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}
{{- end }}

{{- define "postgres.fullname" -}}
{{ include "postgres.name" . }}
{{- end }}
