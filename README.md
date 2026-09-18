# cbuild

Trabalho Prático 1 — Desenvolvimento de uma ferramenta de automação para projetos em C utilizando Bash.

O `cbuild` foi desenvolvido para facilitar tarefas comuns durante o desenvolvimento de projetos em C, como compilação, execução, limpeza dos arquivos gerados, consulta de informações do projeto e registro das operações realizadas.

A ferramenta é executada diretamente pelo terminal e foi organizada de forma modular, separando suas principais funcionalidades em diferentes arquivos.

## Estrutura do projeto

```text
cbuild/
├── cbuild
├── cbuild.conf
├── README.md
├── lib/
│   ├── build.sh
│   ├── rebuild.sh
│   ├── run.sh
│   ├── clean.sh
│   ├── info.sh
│   ├── logs.sh
│   ├── errors.sh
│   └── config.sh
├── src/
├── include/
├── build/
└── logs/
```

O arquivo `cbuild` é o ponto de entrada da ferramenta.

Os módulos localizados em `lib/` concentram as diferentes funcionalidades do sistema. Os arquivos-fonte do projeto em C ficam em `src/`, enquanto arquivos auxiliares e cabeçalhos podem ficar em `include/`.

Os diretórios `build/` e `logs/` são utilizados para armazenar os arquivos gerados durante a utilização da ferramenta.

## Pré-requisitos

O projeto foi desenvolvido para ambiente Linux utilizando Bash.

É necessário possuir:

- Bash;
- compilador GCC;
- utilitários padrão de sistemas Linux, como `find`, `grep`, `awk`, `wc` e `tail`.

Antes da primeira execução, caso necessário, conceda permissão de execução ao script principal:

```bash
chmod +x cbuild
```

## Utilização

A sintaxe geral da ferramenta é:

```bash
./cbuild <comando> [opções]
```

Os comandos disponíveis são:

| Comando | Descrição |
|---|---|
| `build` | Compila o projeto |
| `run` | Executa o programa compilado |
| `clean` | Remove os artefatos gerados pela compilação |
| `rebuild` | Realiza uma limpeza e recompila o projeto |
| `info` | Exibe informações e estatísticas do projeto |

## Exemplos de uso

### Compilar o projeto

```bash
./cbuild build
```

O comando procura os arquivos `.c` no projeto, compila os arquivos necessários e gera o executável dentro do diretório de build configurado.

### Executar o programa

```bash
./cbuild run
```

O comando executa o programa anteriormente gerado pelo `build`.

Na versão utilizada para demonstração, a execução produz:

```text
Ola, mundo
cbuild funcionando com sucesso
```

### Limpar os arquivos gerados

```bash
./cbuild clean
```

O comando remove os artefatos existentes dentro do diretório de build.

### Recompilar o projeto

```bash
./cbuild rebuild
```

Diferentemente do `build` incremental, o `rebuild` realiza uma recompilação completa dos arquivos do projeto.

### Consultar informações

```bash
./cbuild info
```

O comando apresenta informações como:

- quantidade de arquivos `.c` e `.h`;
- quantidade total de linhas de código;
- tamanho do executável;
- data da última compilação bem-sucedida;
- data da última execução bem-sucedida.

## Modo verboso

O modo verboso apresenta informações adicionais sobre as etapas realizadas pela ferramenta.

Exemplo:

```bash
./cbuild build --verbose
```

Também pode ser utilizado em outros comandos que possuem suporte ao modo verboso, como `run`, `clean` e `rebuild`.

## Modo debug

O modo debug permite acompanhar o fluxo interno de execução dos comandos Bash.

Exemplo:

```bash
./cbuild build --debug
```

Durante a execução são exibidas mensagens identificadas por:

```text
[DEBUG TRACE]
```

Esse modo é útil para acompanhar comandos, condicionais, funções e outras operações realizadas internamente pela ferramenta.

## Compilação incremental

O comando `build` utiliza compilação incremental para evitar recompilações desnecessárias.

Após uma compilação, cada arquivo-fonte `.c` é comparado com seu respectivo arquivo objeto `.o`.

Caso o arquivo-fonte não tenha sido alterado desde a última compilação, seu objeto pode ser reutilizado.

Quando apenas parte do projeto é modificada, somente os arquivos necessários são recompilados.

O comando `rebuild`, por outro lado, ignora essa verificação e realiza uma recompilação completa.

## Arquivo de configuração

O comportamento da ferramenta pode ser personalizado através do arquivo:

```text
cbuild.conf
```

Exemplo de configuração:

```bash
EXEC_NAME=meuprograma
CFLAGS="-Wall -Wextra"
BUILD_DIR=build
```

As opções possuem os seguintes significados:

- `EXEC_NAME`: nome do executável gerado;
- `CFLAGS`: opções utilizadas durante a compilação;
- `BUILD_DIR`: diretório onde serão armazenados os arquivos gerados.

Caso alguma configuração não seja definida, a ferramenta utiliza os valores padrão definidos pelo projeto.

## Logs

As operações realizadas pela ferramenta são registradas no arquivo:

```text
logs/cbuild.log
```

Cada registro possui informações como:

- data;
- horário;
- comando executado;
- tempo de execução;
- código de retorno;
- mensagem da operação.

## Geração de relatório

O comando `info` também permite gerar um relatório sobre o estado do projeto e o histórico das operações.

Para gerar o relatório:

```bash
./cbuild info --report
```

O arquivo será criado em:

```text
logs/relatorio.txt
```

Um relatório pode apresentar informações semelhantes a:

```text
=== Relatório do Projeto ===
Arquivos (.c/.h): 2
Linhas de código: 14
Tamanho do executável: 6.3K
Última compilação: 2026-09-17
Última execução: 2026-09-17

=== Histórico de Operações ===
Builds executados: 1 (sucesso: 1, falha: 0)
Runs executados: 1 (sucesso: 1, falha: 0)
```

## Tratamento de erros

A ferramenta possui tratamento para diferentes situações de erro, incluindo:

- diretório ou estrutura esperada inexistente;
- compilador não disponível;
- erro durante a compilação;
- ausência de arquivos `.c`;
- permissão insuficiente;
- comando ou opção inválida;
- tentativa de executar `run` sem que exista um executável compilado.

Quando ocorre uma falha, a ferramenta apresenta uma mensagem informando o problema e utiliza um código de retorno diferente de zero.

## Organização do desenvolvimento

Durante o desenvolvimento foi utilizada a branch `develop` para reunir e testar as funcionalidades antes da integração

A branch `main` contém a versão final do projeto.
