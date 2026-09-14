#!/bin/bash

#Criação da função log_write
#log_write vai escrever no arquivo logs.cbuild.log informações como:
#hora, data, comando, tempo de compilação, código retornado e mensagem 
#argumentos necessário (em ordem): comando,tempo de compilação e código retornado, mensagem é opcional 
#caso esqueça de chamar mensagem, vamos definir o valor padrão como "sucesso"
function log_write(){

local data #variável usada para guardar a data 
local hora #variável usada para guardar o tempo na hora da chamada

data=$(date +%Y-%m-%d) #sistema guarda data no dia que chamar log_write
hora=$(date +%H:%M:%S)

local comando="$1" #comando é o primeiro argumento
local tempo="$2" #tempo de compilação (variável que build trará) é o segundo arg (argumento)
local code="$3" #código retornado é o terceiro argumento
local mensg="${4:-sucesso}" #mensagem é o quarto argumento,caso não seja passado o 4 argumento, a mensagem padrão imprimida sera sucesso


mkdir -p logs #caso o diretório logs não exista, log_write cria ele 
echo "$data|$hora|$comando|$tempo|$code|$mensg" >> logs/cbuild.log #faz o echo do log e redireciona para o arquivo logs.cbuild.log
}