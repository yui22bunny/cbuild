#!/usr/bin/env bash

# run_execute
# Executa o programa compilado.
# Argumentos: nenhum.
# Retorno:
#   0 - sucesso
#   7 - executavel nao encontrado
run_execute() {
    local executavel="$BUILD_DIR/$EXEC_NAME"

    if [ ! -x "$executavel" ]; then
        echo "Erro: executavel nao encontrado"
        return 7
    fi

    "$executavel"
}
