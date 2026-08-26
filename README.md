cbuild

Trabalho Prático 1 —.

Organização do projeto

O desenvolvimento está dividido entre quatro módulos principais.

Integrante A — Build e Rebuild

Responsável por:

- comando "build"
- comando "rebuild"
- compilação incremental

Branch:

"build-rebuild"

Arquivos principais:

- "src/build.sh"

Integrante B — Run, Clean e Info

Responsável por:

- comando "run"
- comando "clean"
- comando "info"
- estatísticas do projeto

Branch:

"run-clean-info"

Arquivos principais:

- "src/run.sh"
- "src/clean.sh"
- "src/info.sh"

Integrante C — Logs e Tratamento de Erros

Responsável por:

- tratamento dos erros obrigatórios
- sistema de logs
- registro das operações

Branch:

"logs-erros"

Arquivos principais:

- "src/logs.sh"
- "src/errors.sh"

Integrante D — Funcionalidades Adicionais

Responsável por:

- modo verboso
- modo debug
- níveis de otimização
- arquivo de configuração
- geração de relatórios

Branch:

"features-extra"

Arquivos principais:

- "src/config.sh"
- "src/report.sh"

Estrutura inicial

cbuild/
├── cbuild
├── README.md
├── .gitignore
├── src/
│   ├── build.sh
│   ├── run.sh
│   ├── clean.sh
│   ├── info.sh
│   ├── logs.sh
│   ├── errors.sh
│   ├── config.sh
│   ├── report.sh
│   └── utils.sh
└── tests/

Organização das branches

A branch "main" será utilizada para a versão estável do projeto.

A branch "develop" será utilizada para integrar e testar o trabalho dos quatro integrantes.

Cada integrante deverá desenvolver sua parte em uma branch própria:

main
└── develop
    ├── build-rebuild
    ├── run-clean-info
    ├── logs-erros
    └── features-extra

As alterações deverão ser integradas primeiro na branch "develop". Depois dos testes do grupo, a versão estável poderá ser integrada à "main".

Fluxo de trabalho

Antes de começar a trabalhar, atualize a branch "develop".

Crie sua branch a partir dela e faça commits descritivos durante o desenvolvimento.

Evite realizar alterações diretamente na branch "main".

Execução

A sintaxe básica prevista para a ferramenta será:

./cbuild <comando> [opções]

Comandos obrigatórios:

./cbuild build
./cbuild run
./cbuild clean
./cbuild rebuild
./cbuild info

Esta documentação será atualizada conforme o desenvolvimento do projeto.
