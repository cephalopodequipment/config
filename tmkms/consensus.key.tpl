{{- range secrets "signing_keys" -}}
{{- if eq . (env "PRIV_KEY_NETWORK") -}}
{{- with secret (printf "signing_keys/%s" . ) -}}
{{- range $k, $v := .Data.data -}}
{{- if eq $k (env "PRIV_KEY_NAME") -}}
{{ $v }}
{{- end -}}{{- end -}}{{- end -}}{{- end -}}{{- end -}}