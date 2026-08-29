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

#erro_n_dic: o erro de não existir o diretório, a build não acha ele 
#argumentos: cam (caminho atual)
#retorna sempre 1 
error_n_dic(){
    local cam="$1" #guarda a variável do caminho que será utilizado depois 
    echo "Erro: o diretório não foi encontrado pela build: $cam">&2 #utiliza a variável caminho para indicar o caminho e encaminha para stderr
    log_write "build" "0s" "1" "Erro: o diretório não foi encontrado pela build: $cam" #utiliza a função log_write para escrever o log de erro_n_dic
    exit 1 #devolve o valor 1 (código do erro) e termina o script
}

#error_gcc: o gcc não foi instalado 
#não recebe nenhum argumento 
#retorna sempre 2 
error_gcc(){
    echo "Erro: o gcc não foi instalado ">&2 #a função leva a mensagem de erro para o canal stderr
    log_write "build" "0s" "2" "Erro: o gcc não foi instalado " #utiliza log_write e escre o log de erro_gcc
    exit 2 #retorna o valor 2 (código do erro do gcc) e termina o script 
}

#error_compile: uma função que diz que o erro foi de compilação do gcc
#recebe um argumento opcional (uma mensagem) que o gcc produz 
#retorna sempre 3 
error_compile(){
    local msg="${1:-Falha em compilar}" #coloca a mensagem como padrão, caso não receba nenhuma mensagem do GCC
    echo "Erro na compilação: $msg">&2 #direciona para o canal stderr
    log_write "build" "0s" "3" "Erro: $msg"
    exit 3 #retorna o código 3 e encerra o script 
}

#error_n_src: uma função que diz que dá erro quando o arquivo não existe, ou não foi encontrado 
#argumento: não necessita de argumento 
#retorna sempre 4

error_n_src(){
    echo "O arquivo .c não foi encontrado no src">&2 #encaminha para o canal stderr (de erro)
    log_write "build" "0s" "4" "Erro: o arquivo .c não foi encontrado no src" #utiliza log_write para escrever o log 
    exit 4 #retorna o valor 4 e termina o script 
}