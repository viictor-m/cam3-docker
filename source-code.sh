#!/bin/bash

path=$(pwd)

echo " "
echo "criando pasta $path/src"
echo " "

mkdir src

########################################################################################
# Baixa o Gdrive a partir do seu repositório Github, decompacta e permite execução.
# Globals:
#   PARENTPATH
# Arguments:
#   None
########################################################################################
instalar () {
    wget "https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_386.tar.gz"
    tar -zxvf gdrive_2.1.1_linux_386.tar.gz -C "$path/"
    rm gdrive_2.1.1_linux_386.tar.gz
    chmod +x "$path/gdrive"
}

########################################################################################
# Executa a autenticação do Gdrive na sua conta Google
# Globals:
#   PARENTPATH
# Arguments:
#   None
########################################################################################

autenticar () {
    "$path/gdrive" about
}

########################################################################################
# Modelo, ferramentas relativas e bibliotecas necessárias para instalação. 
# 
# Espera-se que os nomes abaixo existem em qualquer lugar do seu Google Drive.
# Tanto faz o canto, pois o script usa o ID único dos arquivos, mas os nomes
# precisam ser exatos.
# 
# obs.: não podem existir outros arquivos com o mesmo nome no Google Drive.
########################################################################################
ARQUIVOS=(
    "cam3.0_landsurf_datasets.tar.gz"
    "cam3.1_128x256_T85_datasets.tar.gz"
    "cam3.1_forall_datasets.tar.gz"
    "cam3.1.p2_source_code.tar.gz"
)


########################################################################################
# Baixa o modelo, ferramentas relativas e bibliotecas necessárias para instalação.
# Globals:
#   PARENTPATH
#   ARQUIVOS
# Arguments:
#   1. Diretório de persistência dos arquivos
########################################################################################
download () {
    echo "baixando tudo: relaxou, pois pode demorar até o output começar a aparecer..."
    for i in "${ARQUIVOS[@]}"; do
        ID=$($path/gdrive list -m 10 --query "name contains '$i'" |\
            awk '{print $1}' |\
            awk 'NR==2')
        $path/gdrive download $ID --skip --path $path/src/$1
        tar -zxvf "$path/src/$i" -C "$path/src/"
        rm $path/src/$i
    done
    echo "todas as dependências foram baixadas."
}

"$@"