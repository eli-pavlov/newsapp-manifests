{{- define "frontend.name" -}}
{{- if .Values.nameOverride }}{{- .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- else }}{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}{{- end -}}
{{- end }}

{{- define "frontend.fullname" -}}
{{- if .Values.fullnameOverride }}{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := include "frontend.name" . -}}
{{- if contains $name .Release.Name }}{{ .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}{{ printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}{{- end -}}
{{- end -}}
{{- end }}

{{- define "frontend.component" -}}
{{- if .Values.app.name }}{{ .Values.app.name | trunc 63 | trimSuffix "-" }}{{ else }}{{ .Chart.Name | trunc 63 | trimSuffix "-" }}{{ end -}}
{{- end }}

{{- define "frontend.labels" -}}
app.kubernetes.io/name: {{ include "frontend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: {{ include "frontend.component" . }}
{{- end }}
