#!/bin/bash
source ./erros.sh
source ../include/extra.sh

VERBOSE=0
DEBUG=0

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

verb "Verificando a existência do cbuild.conf no diretório."
#Verificando existencia do cbuild.conf no diretorio
if [[ ! -f "cbuild.conf" ]]; then
    error_n_dic 
fi  

source ./cbuild.conf

verb "Verificando se o GCC está instalado."
#Verificando se o GCC esta instalado
if ! gcc --version &> /dev/null; then
    error_gcc
fi

verb "Verificando se existem arquivos.c"
#Verificando se existem arquivos .c 
if ! find ./src -name "*.c" -type f | grep -q .; then
    error_n_src
fi

#cria um array chamado arquivos_c e põe em cada posição um arquivo .c encontrado em src
mapfile -t arquivos_c < <(find ./src -name "*.c" -type f)
debug "Arquivos .c encontrados no diretório: ${arquivos_c[*]}"

verb "Gerando o diretório build."


mkdir -p "$BUILD_DIR" #cria o diretório build caso não exista
rm -f "$BUILD_DIR"/*.o #remove os arquivos .o antigos do diretório build

total=${#arquivos_c[@]}
contador=0

for arquivo in "${arquivos_c[@]}"; do
 #Caso o modo verboso esteja ativado, mostra o progresso de compilação
 if [[ $VERBOSE -eq 1 ]]; then
    contador=$((contador + 1))
    printf "\rCompilando arquivos (%d/%d): %s" "$contador" "$total" "$(ba>
 fi
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

