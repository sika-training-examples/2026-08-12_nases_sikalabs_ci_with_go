#!/usr/bin/env bash

run_script="run.sh"

params="${@}"

echo "chceme spustit ${run_script} ${params}"

curl -s https://git.pss.sk/api/v4/projects/283/repository/files/run.sh/raw?ref=feature/ALPHAX-10047_uprava_templates_pre_vault_secrets > ${run_script}
chmod +x ${run_script}
./${run_script} ${params}
rm ${run_script}
