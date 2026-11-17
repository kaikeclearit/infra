# clearit-claude

Marketplace interno da ClearIT para o Claude Code. Distribui o plugin **clearit-agents** com os agentes especialistas do time.

## Agentes incluídos

| Agente | Uso |
|---|---|
| `code-architect` | Desenho de arquitetura e decisões técnicas |
| `code-documenter` | Documentação de código e projetos |
| `code-generator` | Implementação de código novo |
| `code-reviewer` | Revisão de código antes de PR/MR (somente leitura) |
| `debugger` | Investigação e correção de bugs |
| `devops-engineer` | CI/CD, containers, IaC |
| `diagram-generator` | Diagramas (arquitetura, fluxos) |
| `frontend-developer` | Desenvolvimento de interfaces |
| `llm-benchmarker` | Comparação e avaliação de LLMs |
| `log-analyzer` | Análise de logs e incidentes |
| `observability-engineer` | Monitoramento, métricas, Dynatrace |
| `security-auditor` | Auditoria de segurança do código (somente leitura) |
| `vulnerability-analyst` | Análise de vulnerabilidades/CVEs |

## Estrutura

```
clearit-claude/
├── .claude-plugin/marketplace.json     ← catálogo "clearit"
├── plugins/clearit-agents/
│   ├── .claude-plugin/plugin.json
│   ├── agents/                         ← subagentes (.md)
│   └── skills/                         ← skills (pasta/SKILL.md)
└── vm-setup/
    ├── install.sh                      ← instalação manual numa VM
    └── settings.json                   ← modelo para imagem/template de VM
```

## Publicar

Repositório: `git@github.com:kaikeclearit/infra.git`. Nesta pasta:
```bash
git init && git add . && git commit -m "Plugin clearit-agents v1.0.0"
git remote add origin git@github.com:kaikeclearit/infra.git
git push -u origin main
```

## Instalar numa VM

Pré-requisitos: Claude Code instalado e autenticado, e acesso Git ao repositório (chave SSH de deploy ou token, se for privado).

```bash
claude plugin marketplace add git@github.com:kaikeclearit/infra.git
claude plugin install clearit-agents@clearit
```

Ou use o script: `./vm-setup/install.sh git@github.com:kaikeclearit/infra.git`.

Conferir: abra `claude` e rode `/agents` — os agentes aparecem com o prefixo do plugin.

## VMs criadas por template (Ansible, cloud-init, imagem)

Copie `vm-setup/settings.json` (com a URL real) para `~/.claude/settings.json` do usuário da VM. Na primeira execução o Claude Code reconhece o marketplace `clearit` e habilita o plugin automaticamente.

Para impor a todos os usuários da máquina, use o arquivo de configuração gerenciada (`/etc/claude-code/managed-settings.json` no Linux).

## Atualizar

1. Edite os agentes/skills e suba a `version` em `plugins/clearit-agents/.claude-plugin/plugin.json` e em `.claude-plugin/marketplace.json`.
2. Commit + push.
3. Nas VMs:
   ```bash
   claude plugin marketplace update clearit
   ```
