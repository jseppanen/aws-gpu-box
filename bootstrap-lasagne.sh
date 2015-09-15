#!/bin/bash

set -e

# Theano needs g++ and python-dev
sudo apt-get install -y \
     git wget \
     build-essential g++ python-dev

wget https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
/bin/bash Miniconda-latest-Linux-x86_64.sh -b

export PATH=$HOME/miniconda/bin:$PATH
echo -e "\nexport PATH=$HOME/miniconda/bin:\$PATH\n" >> .bashrc

conda update -y conda
conda install -y pip

pip install awscli

# install Lasagne 0.1
conda install -y numpy scipy matplotlib seaborn ipython ipython-notebook

# Lasagne requires a specific Theano snapshot
pip install -r https://raw.githubusercontent.com/Lasagne/Lasagne/v0.1/requirements.txt
pip install Lasagne==0.1

echo -e "\n[global]\nfloatX=float32\ndevice=gpu\n[lib]\ncnmem=0.9\n[nvcc]\nfastmath=True\n[cuda]\nroot=/usr/local/cuda" >> ~/.theanorc
