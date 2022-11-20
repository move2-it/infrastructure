# infrastructure

```shell
 cd environments/dev
 export TF_TOKEN_app_terraform_io="token"
 export TF_VAR_akeyless_access_id="access_id"
 export TF_VAR_akeyless_access_key="secret_key"
 export TF_VAR_kubernetes_url="kubernetes_url"
 terraform init && terraform apply
```