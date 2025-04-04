{{- with secret (printf "%s" (env "TMKMS_VAULT_PATH")) -}}
{{- .Data.data.tmkms_signing_key -}}
{{- end -}}
