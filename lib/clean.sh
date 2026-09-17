#!/usr/bin/env bash

# clean_execute
# Argumentos: nenhum
# Remove os arquivos gerados durante a compilacao
# Retorno:
#   0 - sucesso
#   5 - permissao insuficiente
# 
VERBOSE=0
DEBUG=0

clean_execute() {
  while [[ $# -gt 0 ]]; do 
  #Ativa o modo verboso se o usuário digitar a opção --verbose
   if [[ "$1" == "--verbose" ]]; then
    VERBOSE=1
    shift
  #Ativa o modo debug caso o usuário digite a opção --debug
  elif [[ "$1" == "--debug" ]]; then
    DEBUG=1
    shift
  else
    shift
  fi 
done

#ativa o trace de comandos do bash se o usuário ativar o modo debug. Desse modo, até o fim do script todo comando executado será impresso no terminal (prefixado com "+ [DEBUG TRACE]"), incluindo os comandos dentro das funções verb/debug e de todos ifs e loops

if [[ $DEBUG -eq 1 ]]; then
  export PS4='+ [DEBUG TRACE] '
  set -x 
fi
    local build_dir="$BUILD_DIR"

    if [ ! -d "$build_dir" ]; then
        echo "Diretorio de build nao existe"
        return 0
    fi

    if [ ! -w "$build_dir" ]; then
        echo "Erro: permissao insuficiente"
        return 5
    fi
    verb "Removendo conteúdo de $build_dir/"
    rm -rf "$build_dir"/*
    return 0
}
