#!/bin/sh

set -e

scp bootstrap-cuda.sh bootstrap-lasagne.sh bootstrap-torch.sh gpubox:
# first run will disable nouveau and reboot
ssh gpubox bash bootstrap-cuda.sh
sleep 60
# second run will install the nvidia stuff
ssh gpubox bash bootstrap-cuda.sh
ssh gpubox bash bootstrap-lasagne.sh
ssh gpubox bash bootstrap-torch.sh
