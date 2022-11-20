# infrastructure

```shell
 ./scripts/get_okteto_kubeconfig.sh okteto_token
 cd environments/dev
 export TF_TOKEN_app_terraform_io="token"
 export TF_VAR_akeyless_access_id="akeyless_access_id"
 export TF_VAR_akeyless_access_key="akeyless_access_key"
 terraform init && terraform apply
```