#!/bin/bash

set -e

# install Torch
curl -sk https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
git clone https://github.com/torch/distro.git ~/torch --recursive
cd ~/torch; ./install.sh
cd ..
export PATH=$HOME/torch/install/bin:$PATH

luarocks install nngraph
luarocks install optim
luarocks install cutorch
luarocks install cunn
