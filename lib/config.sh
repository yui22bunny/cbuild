#!/bin/bash

#load_config() carrega as configurações do cbuild.conf, caso ele exista. Caso não exista, carrega as configurações padrão.
#argumentos: nenhum
#retorno: nenhum
load_config() {
    EXEC_NAME="a.out"
    CFLAGS="-Wall"
    BUILD_DIR="build"

    if [ -f "cbuild.conf" ]; then
        source "cbuild.conf"
    fi
}