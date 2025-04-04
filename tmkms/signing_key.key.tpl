{{- with secret (printf "%s" (env "TMKMS_VAULT_PATH")) -}}
{{- .Data.data.(printf "%s" (env "CHAIN_ID")) -}}
{{- end -}}
