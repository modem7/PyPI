# PyPI repository

Static PyPI repository for personal Python packages. Built with [dumb-pypi](https://github.com/chriskuehl/dumb-pypi) and hosted with GitHub Pages.

## Web interface

See https://modem7.github.io/PyPI/

## Updating the static pages with new packages

### Run on the repository root:

```
dumb-pypi --package-list <(ls packages) \
    --packages-url https://raw.githubusercontent.com/modem7/PyPI/gh-pages/packages \
    --output-dir .
```

# Full instructions on updating Borgmatic wheels:

### Requirements:
- [dumb-pypi](https://pypi.org/project/dumb-pypi/)
  - `pip install dumb-pypi`

- [QEMU Emulation](https://www.stereolabs.com/docs/docker/building-arm-container-on-x86/#setting-up-arm-emulation-on-x86)
  - Install the qemu packages:
    - `sudo apt-get install qemu binfmt-support qemu-user-static`

  - Execute the registering scripts:
    - `docker run --rm --privileged multiarch/qemu-user-static --reset -p yes`

### Clone the repo:
`git clone https://github.com/modem7/PyPI.git && cd PyPI`

### Run the script. 
This will build the wheels for x86_64 and arm64, and create a suitable gh-pages set of files.

`./build_borg_wheels.sh`

### Using the index:
In the requirements.txt of the end install, you'll need to add: `--extra-index-url https://modem7.github.io/PyPI/simple`

E.g.

```
--extra-index-url https://modem7.github.io/PyPI/simple

llfuse==1.4.2
borgbackup==1.2.1
borgmatic==1.6.3
```
