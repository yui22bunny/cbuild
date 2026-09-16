#!/bin/bash

source ./lib/errors.sh
source ./lib/logs.sh
source ./include/extra.sh
source ./lib/config.sh
source ./lib/build.sh
source ./lib/rebuild.sh
source ./lib/clean.sh
source ./lib/info.sh
source ./lib/run.sh

#Carrega as configurações
load_config

#Obtém o comando passado como primeiro argumento 
comando="$1"
#Executa a função correspondente ao comando digitado
case "$comando" in
	build)
		build
		;;
	rebuild)
		rebuild
		;;
	clean)
		clean
		;;
	info)
		info
		;;
	run)
		run
		;;
	*)
		error_command
		;;
esac
