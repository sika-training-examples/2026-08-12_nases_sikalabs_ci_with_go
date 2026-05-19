# 2026-05-19_asseco_db_terraform_example

## Connect to PostgreSQL

The PostgreSQL server has no public access. Connect via the example VM inside the VNet.

### SSH into the VM

```bash
ssh az@$(terraform output -raw example_ip)
```

### Install PostgreSQL client (first time)

```bash
sudo apt-get update && sudo apt-get install -y postgresql-client-14 jq
```

### Connect with password auth

```bash
psql "host=$(terraform output -raw postgres_fqdn) port=5432 dbname=postgres user=pgadmin password=ChangeMe123! sslmode=require"
```

### Connect with Entra (your user)

```bash
# Run locally to get the token, then SSH and use it
az account get-access-token --resource-type oss-rdbms --query accessToken -o tsv
```

```bash
# On the VM
TOKEN=<paste token>
UPN=$(terraform output -raw current_user_upn)
psql "host=$(terraform output -raw postgres_fqdn) port=5432 dbname=postgres user=$UPN password=$TOKEN sslmode=require"
```

### Connect with VM managed identity (from the VM)

```bash
TOKEN=$(curl -s 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fossrdbms-aad.database.windows.net' -H 'Metadata: true' | jq -r .access_token)
USER=$(echo $TOKEN | cut -d'.' -f2 | base64 -d 2>/dev/null | jq -r '.xms_mirid // .xms_az_rid' | awk -F'/' '{print $NF}')
psql "host=ondrejsika3-psql.postgres.database.azure.com port=5432 dbname=postgres user=$USER password=$TOKEN sslmode=require"
```
