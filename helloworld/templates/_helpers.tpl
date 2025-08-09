{{- define "application.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "application.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
