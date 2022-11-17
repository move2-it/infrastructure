# infrastructure

```shell
 cd environments/dev
 export TF_TOKEN_app_terraform_io="token"
 export TF_VAR_akeyless_access_id="access_id"
 export TF_VAR_akeyless_access_key="secret_key"
 terraform init && terraform apply
```