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

#exec_size: função que calcula o tamanho do executável 
#não tem argumentos 
#retorna o tamanho do executável em bytes
exec_size(){
    local caminho="${BUILD_DIR}/${EXEC_NAME}"
    local tam
    if [ -f "$caminho" ]; then
        tam=$(ls -lh "$caminho" | awk '{print $5}')
    else
        tam="Nenhum executalvel foi encontrado (compile o projeto antes)"
    fi
    echo "$tam"
}