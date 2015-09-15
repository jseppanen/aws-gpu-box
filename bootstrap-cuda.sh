#!/bin/bash

set -e

echo "escape ^Zz" >.screenrc

if [[ ! -e cuda_7.0.28_linux.run ]]
then
    # first run
    sudo apt-get update

    sudo apt-get install -y linux-image-extra-`uname -r` linux-headers-`uname -r` linux-image-`uname -r` build-essential

    # install CUDA
    # needs to be run twice, with reboot in between
    # 1. run cuda installer => will disable nouveau driver
    # 2. sudo update-initramfs -u
    # 3. sudo reboot
    # 4. run cuda installer => will install nvidia driver and cuda toolkit
    wget http://developer.download.nvidia.com/compute/cuda/7_0/Prod/local_installers/cuda_7.0.28_linux.run
    chmod 755 cuda_7.0.28_linux.run 
    sudo ./cuda_7.0.28_linux.run --silent --driver --toolkit --samples --no-opengl-libs
    # check /var/log/nvidia-installer.log for errors

    sudo update-initramfs -u
    sudo reboot
else
    # second run
    sudo ./cuda_7.0.28_linux.run --silent --driver --toolkit --samples --no-opengl-libs
    echo -e "\nexport PATH=/usr/local/cuda/bin:\$PATH" >> .bashrc
    echo -e "\nexport LD_LIBRARY_PATH=/usr/local/cuda/lib64:\$LD_LIBRARY_PATH" >> .bashrc

    if (nvidia-smi -q | grep -q GPU); then
        echo "CUDA installed successfully"
    else
        cat /var/log/nvidia-installer.log
        exit 1
    fi
fi

# install cuDNN if tarball given
if [[ -e cudnn-7.0-linux-x64-v3.0-rc.tgz ]]; then
    cd /usr/local
    sudo tar xzf $HOME/cudnn-7.0-linux-x64-v3.0-rc.tgz
fi
