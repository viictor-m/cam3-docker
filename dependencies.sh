#!/bin/bash

#Download das dependencias do cam 3.1 para pasta dependencies

path=$(pwd)

echo " "
echo "criando pasta $path/dependencies"
echo " "

mkdir dependencies

declare -A fontes

fontes["netcdf-4.1.3"]="https://github.com/Unidata/netcdf-c/archive/refs/tags/netcdf-4.1.3.tar.gz"
fontes["openmpi-4.1.1"]="https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.1.tar.gz"
fontes["portland-compilers"]="https://developer.download.nvidia.com/hpc-sdk/21.9/nvhpc_2021_219_Linux_x86_64_cuda_11.4.tar.gz"

for biblioteca in ${!fontes[@]}; do
    echo " "
    echo "baixando $biblioteca ..." 
    echo " "
    wget ${fontes[${biblioteca}]} -O "$path/dependencies/$biblioteca.tar.gz"

    echo " "
    echo "descompactando $biblioteca ..."
    echo " "
    tar -zxvf "$path/dependencies/$biblioteca.tar.gz" -C "$path/dependencies/"
    rm "$path/dependencies/$biblioteca.tar.gz"
done



