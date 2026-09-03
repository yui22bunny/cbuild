#!/bin/bash
#count_file: uma função que conta quantos arquivos .c e .h existem
#argumentos: nenhum
#retorna a quantidade de arquivos .c e .h 
count_file(){
    local numero
    numero=$(find src include -name "*.c" -o -name "*.h" | wc -l)
    echo "$numero"
}

#count_linecode: uma função que conta a quantidade de linhas de código de todos os arquivos .c e .h
#argumentos: nenhum
#retorna a quantidade de linhas de código do projeto
count_linecode(){
    local total
    total=$(find src include -name "*.c" -o -name "*.h" | xargs wc -l | tail -1 | awk '{print $1}')
    echo "$total"
}