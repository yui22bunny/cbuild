#!/usr/bin/env bash

# clean_execute
# Remove os arquivos gerados durante a compilacao
# Retorno:
#   0 - sucesso
#   5 - permissao insuficiente
clean_execute() {
    local build_dir="$BUILD_DIR"

    if [ ! -d "$build_dir" ]; then
        echo "Diretorio de build nao existe"
        return 0
    fi

    if [ ! -w "$build_dir" ]; then
        echo "Erro: permissao insuficiente"
        return 5
    fi

    rm -rf "$build_dir"/*
    return 0
}
