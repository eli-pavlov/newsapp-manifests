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

{{- define "app.component" -}}
{{- if .Values.app.name }}{{ .Values.app.name | trunc 63 | trimSuffix "-" }}{{ else }}{{ .Chart.Name | trunc 63 | trimSuffix "-" }}{{ end -}}
{{- end }}

{{- define "app.labels" -}}
app.kubernetes.io/name: {{ include "app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: {{ include "app.component" . }}
{{- end }}

{{- define "app.selectorLabels" -}}
app.kubernetes.io/component: {{ include "app.component" . }}
{{- end }}