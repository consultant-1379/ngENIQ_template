{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "ngENIQ_template.name" }}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart version as used by the chart label.
*/}}
{{- define "ngENIQ_template.version" }}
{{- printf "%s" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ngENIQ_template.fullname" }}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- $name | trunc 63 | trimSuffix "-" }}
{{/* Ericsson mandates the name defined in metadata should start with chart name. */}}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ngENIQ_template.chart" }}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{/*
Create image repo path
*/}}
{{- define "ngENIQ_template.repoPath" }}
{{- if .Values.imageCredentials.repoPath }}
{{- print .Values.imageCredentials.repoPath "/" }}
{{- end }}
{{- end }}

{{/*
Create image registry url
*/}}
{{- define "ngENIQ_template.registryUrl" }}
    {{- $registryURL := "armdocker.rnd.ericsson.se" }}
    {{-  if .Values.global }}
        {{- if .Values.global.registry }}
            {{- if .Values.global.registry.url }}
                {{- $registryURL = .Values.global.registry.url }}
            {{- end }}
        {{- end }}
    {{- end }}
    {{- if .Values.imageCredentials.registry }}
        {{- if .Values.imageCredentials.registry.url }}
            {{- $registryURL = .Values.imageCredentials.registry.url }}
        {{- end }}
    {{- end }}
    {{- print $registryURL }}
{{- end -}}

{{/*
Create image pull secrets
*/}}
{{- define "ngENIQ_template.pullSecrets" }}
{{- $pullSecret := "" }}
{{- if .Values.global }}
    {{- if .Values.global.pullSecret }}
        {{- $pullSecret = .Values.global.pullSecret }}
    {{- end }}
{{- end }}
{{- if .Values.imageCredentials }}
    {{- if .Values.imageCredentials.pullSecret }}
        {{- $pullSecret = .Values.imageCredentials.pullSecret }}
    {{- end }}
{{- end }}
{{- print $pullSecret }}
{{- end }}
{{/*
Timezone variable
*/}}
{{- define "ngENIQ_template.timezone" }}
{{- $timezone := "UTC" }}
{{- if .Values.global }}
    {{- if .Values.global.timezone }}
        {{- $timezone = .Values.global.timezone }}
    {{- end }}
{{- end }}
{{- print $timezone | quote }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "ngENIQ_template.labels" }}
app.kubernetes.io/name: {{ include "ngENIQ_template.name" . }}
helm.sh/chart: {{ include "ngENIQ_template.chart" . }}
{{ include "ngENIQ_template.selectorLabels" . }}
app.kubernetes.io/version: {{ include "ngENIQ_template.version" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "ngENIQ_template.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ngENIQ_template.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ngENIQ_template.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ngENIQ_template.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
TODO: Please change this product number to a valid one, once it is available.
*/}}
{{- define "ngENIQ_template.product-info" }}
ericsson.com/product-name: "Microservice Chassis"
ericsson.com/product-number: "CXC90001"
ericsson.com/product-revision: "{{ .Values.productInfo.rstate }}"
{{- end }}

