{{/*
Expand the name of the chart.
*/}}
{{- define "nextjs-fe.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nextjs-fe.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nextjs-fe.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nextjs-fe.labels" -}}
helm.sh/chart: {{ include "nextjs-fe.chart" . }}
{{ include "nextjs-fe.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nextjs-fe.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nextjs-fe.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Cattle Selector labels
*/}}
{{- define "nextjs-fe.cattleSelectorLabels" -}}
app.kubernetes.io/name: {{ include "nextjs-fe.name" . }}-cattle
app.kubernetes.io/instance: {{ .Release.Name }}
unit: "cattle"
{{- end }}

{{/*
Varnish Selector labels
*/}}
{{- define "nextjs-fe.varnishSelectorLabels" -}}
app.kubernetes.io/name: {{ include "nextjs-fe.name" . }}-varnish
app.kubernetes.io/instance: {{ .Release.Name }}
unit: "varnish"
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nextjs-fe.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "nextjs-fe.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
