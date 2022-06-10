# These are old instructions, but keeping it for historical purposes.
## New instructions [here](https://github.com/modem7/PyPI/blob/gh-pages/README.md)

# Instructions for building Borgmatic wheels

### Potential prerequesites: 
From [Setting up ARM emulation on x86](https://www.stereolabs.com/docs/docker/building-arm-container-on-x86/#setting-up-arm-emulation-on-x86)

```
# Install the qemu packages
sudo apt-get install qemu binfmt-support qemu-user-static

# This step will execute the registering scripts
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

# Testing the emulation environment
docker run --rm -t arm64v8/ubuntu uname -m
aarch64
```

### Clone the repo:
`git clone https://github.com/modem7/docker-borgmatic-wheels.git && cd docker-borgmatic-wheels`

### For x86_64:
`docker run --rm -v "$(pwd)":/data -w /data -it 'alpine:3.16' sh -c './wheels.sh'`

### For Arm64:
`docker run --rm -v "$(pwd)":/data -w /data -it 'arm64v8/alpine:3.16' sh -c './wheels.sh'`
