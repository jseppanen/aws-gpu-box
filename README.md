# GPU box

## Setup

Launch GPU instance, with:
* `mykey` as AWS key
* `mysg` as security group
* `name` as EC2 instance name
```
./launch.sh mykey mysg name
```

Add `gpubox` to `~/.ssh/config`:

```
Host gpubox
     HostName ec2-1-2-3-4.compute-1.amazonaws.com
     IdentityFile ~/.ssh/mykey.pem
     User ubuntu
     StrictHostKeyChecking no
```

*(Optional)* Download [cuDNN tarball from Nvidia](https://developer.nvidia.com/cudnn) and upload to GPU instance:
```
scp cudnn-7.0-linux-x64-v3.0-rc.tgz gpubox:
```

Install CUDA, Lasagne, and Torch:
```
./bootstrap.sh
```

## IPython notebook

remote:
```
nohup ipython notebook --no-browser --port=8889 > ipython_notebook.log 2>&1 &
```

local:
```
ssh -N -f -L localhost:8889:localhost:8889 gpubox
```
