#!/bin/bash


VERBOSE=0
DEBUG=0

build_run() {
#Verifica as opções do comando, enquanto ainda restar pelo menos 1 argumento
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
#flag -t tira a quebra de linha no final de cada arquivo lido pra não dar erros inesperados
debug "Arquivos .c encontrados no diretório: ${arquivos_c[*]}"

verb "Gerando o diretório build."
mkdir -p "$BUILD_DIR" #cria o diretório build caso não exista
#a flag -p serve pra evitar erro se a pasta já existir, sem a flag caso existisse o diretório daria erro

#descobre quais arquivos realmente precisam recompilar
arquivos_para_compilar=()
for arquivo in "${arquivos_c[@]}"; do
    objeto="$BUILD_DIR/$(basename "$arquivo" .c).o"
    if [[ "$arquivo" -nt "$objeto" ]]; then
        arquivos_para_compilar+=("$arquivo")
    fi
done

total=${#arquivos_para_compilar[@]}
contador=0

# compila só os que precisam
for arquivo in "${arquivos_para_compilar[@]}"; do
    objeto="$BUILD_DIR/$(basename "$arquivo" .c).o"

    if [[ $VERBOSE -eq 1 ]]; then
        contador=$((contador + 1))
        printf "\rCompilando arquivos (%d/%d): %s\033[K" "$contador" "$total" "$(basename "$arquivo")"
    fi

    debug "Recompilando: $arquivo -> $objeto."
    gcc $CFLAGS -c "$arquivo" -o "$objeto"
    if [[ $? -ne 0 ]]; then
        error_compile
    fi
done

[[ $VERBOSE -eq 1 && $contador -gt 0 ]] && echo #caso o verboso esteja ativado quebra a linha depois de imprimir a mensagem de "Compilando arquivos..." do for acima. Se o for nao rodar nenhuma vez, isto é, se nenhum arquivo precisava recompilar, o $contador -gt 0 e essa linha é ignorada

verb "Linkando os arquivos objeto e gerando o executável"
gcc $CFLAGS "$BUILD_DIR"/*.o -o "$BUILD_DIR/$EXEC_NAME"
#$? dá o resultado do último comando
if [[ $? -ne 0 ]]; then
    error_compile
fi
}
