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

#data_compile: função que retorna a data da última compilação 
#sem argumentos
#retorna data da última compilação
data_compile(){
    local data
    data=$(grep "|build|.*|0|" logs/cbuild.log | tail -1 | awk -F'|' '{print $1}')
    if [ -z "$data" ];then
        echo "Não houve nenhuma compilação"
    else 
         echo "$data"
    fi
}
#data_exec: função que retorna a data da última execução
#sem argumentos
#retorna data da última execução
data_exec(){
    local data
    data=$(grep "|run|.*|0|" logs/cbuild.log | tail -1 | awk -F'|' '{print $1}')
    if [ -z "$data" ];then
        echo "Não houve nenhuma execução"
    else 
         echo "$data"
    fi
}
#info_run: função que junta todas as estatísticas de (count_file;count_linecode;exec_size;data_compile;data_exec) em um só relatório
#não tem argumentos
#não retorna nada, imprime na tela o relatório
info_run(){
    local tot_arq tot_line tam_exec ult_comp ult_exec
    tot_arq=$(count_file)
    tot_line=$(count_linecode)
    tam_exec=$(exec_size)
    ult_comp=$(data_compile)
    ult_exec=$(data_exec)

    echo "||||||||||Estatísticas do Projeto||||||||||"
    echo "Quantidade de arquivos (.c/.h): $tot_arq"
    echo "Quantidade de linhas de código: $tot_line"
    echo "Tamanho do executável: $tam_exec"
    echo "Data da última compilação: $ult_comp"
    echo "Data da última execução: $ult_exec"
}

 

