#!/usr/bin/env bash

# run_execute
# Executa o programa compilado.
# Argumentos: nenhum.
# Retorno:
#   0 - sucesso
#   7 - executavel nao encontrado
VERBOSE=0
DEBUG=0

run_execute() {
  #Verifica as opções do comando, enquanto ainda restar pelo menos 1 argume>
  while [[ $# -gt 0 ]]; do 
  #Ativa o modo verboso se o usuário digitar a opção -verbose
    if [[ "$1" == "--verbose" ]]; then
      VERBOSE=1
      shift
  #Ativa o modo debug caso o usuário digite a opção -debug
    elif [[ "$1" == "--debug" ]]; then
      DEBUG=1
      shift
    else
      shift
    fi 
done

#ativa o trace de comandos do bash se o usuário ativar o modo debug. Dess>

  if [[ $DEBUG -eq 1 ]]; then
    export PS4='+ [DEBUG TRACE] '
    set -x 
  fi

    local executavel="$BUILD_DIR/$EXEC_NAME"

    if [ ! -x "$executavel" ]; then
        echo "Erro: executavel nao encontrado"
        return 7
    fi
    verb "Executando o $executavel"
    "$executavel"
}
