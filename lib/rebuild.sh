#!/bin/bash
source ./erros.sh

#Verificando existencia do cbuild.conf no diretorio
if [[ ! -f "cbuild.conf" ]]; then
    error_n_dic 
fi  

source ./cbuild.conf

#Verificando se o GCC esta instalado
if ! gcc --version &> /dev/null; then
    error_gcc
fi

#Verificando se existem arquivos .c 
if ! find ./src -name "*.c" -type f | grep -q .; then
    error_n_src
fi

#cria um array chamado arquivos_c e põe em cada posição um arquivo .c encontrado em src
mapfile -t arquivos_c < <(find ./src -name "*.c" -type f)

mkdir -p "$BUILD_DIR" #cria o diretório build caso não exista
rm -f "$BUILD_DIR"/*.o #remove os arquivos .o antigos do diretório build

for arquivo in "${arquivos_c[@]}"; do
    objeto="$BUILD_DIR/$(basename "$arquivo" .c).o"
    gcc $CFLAGS -c "$arquivo" -o "$objeto"
    if [[ $? -ne 0 ]]; then
        error_compile 
    fi
    done

gcc $CFLAGS "$BUILD_DIR"/*.o -o "$BUILD_DIR/$EXEC_NAME"
if [[ $? -ne 0 ]]; then
        error_compile 
    fi

