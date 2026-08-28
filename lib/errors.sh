#!/bin/bash

#Cada função desse arquivo tratará de um erro 

# erro_n_exec: o erro de não executável, ou seja, o o comando run, não achou o executável para rodar e deu erro
#Nenhum argumento é utiliado nessa função
#retorna sempre 7 e encerra o script
error_n_exec(){
    echo "Erro: o executável não foi encontrado pela função run, utilize build para compilar antes">&2 #redireciona a mensagem para o canal de erros
    log_write "run" "0s" "7" "Erro: o executável não foi encontrado pela função run, utilize build para compilar antes" #escreve o log no arquivo logs/cbuil.log
    exit 7
}