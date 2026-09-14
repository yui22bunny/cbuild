#!/bin/bash

#Criando a função verb() que comunica cada passo do build caso o modo verboso seja ativado
verb() {
  if [[ $VERBOSE -eq 1 ]]; then
    echo "$*"
  fi
}

#Criando a função debug() que facilita a visualização de erros  
debug(){
  if [[ $DEBUG -eq 1 ]]; then
    echo "[DEBUG] $*" >&2 #mandando pro stderr para nao interferir nas informações da saída normal do build
  fi
}
#lembrando que mesmo com as funções declaradas ainda é necessário em cada comando declarar o VERBOSE e o DEBUG, além de ativar o modo trace para o modo debug
