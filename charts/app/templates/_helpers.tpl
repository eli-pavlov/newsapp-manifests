{{- define "app.name" -}}
{{- if .Values.nameOverride }}{{- .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- else }}{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}{{- end -}}
{{- end }}

{{- define "app.fullname" -}}
{{- if .Values.fullnameOverride }}{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := include "app.name" . -}}
{{- if contains $name .Release.Name }}{{ .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}{{ printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}{{- end -}}
{{- end -}}
{{- end }}
