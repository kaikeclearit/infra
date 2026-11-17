#!/usr/bin/env bash
# Instala o marketplace e o plugin da ClearIT numa VM Linux.
# Uso: ./install.sh <url-do-repositorio-git>
set -euo pipefail

REPO_URL="${1:?Informe a URL do repositório Git (ex.: git@github.com:kaikeclearit/infra.git)}"

command -v claude >/dev/null || { echo "Claude Code não encontrado no PATH."; exit 1; }

claude plugin marketplace add "$REPO_URL"
claude plugin install clearit-agents@clearit
echo "OK: plugin clearit-agents instalado. Rode 'claude' e use /agents para conferir."
