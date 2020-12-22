# Epita's Environment in a Docker Container 🐳

The main goal of this repository is to create the perfect environment for every [EPITA](https://www.epita.fr) student in a [Docker™](https://www.docker.com) [container](https://www.docker.com/resources/what-container) 🤯. If you're not from EPITA, you will probably not be interested in this project but you can change it to your needs 😊

## Why a container over a virtual machine? 🖥

Having a container has multiple advantages:
- [x] it is fast
- [x] it is efficient 🚀
- [x] you can have a container per project, so they do not interfere with one another
- [x] there is nothing more than what you need to code
- [x] which means that there is everything you need to code 😎

## How to use? 📋

You have two options. You can either download the pre-compiled image from the Docker Hub, or you can build it from the sources so that you can modify the image as you want.

### Pull image from Docker Hub 🐳

Simply run the following command and you're good to go:

    docker run -it francoisdtm/epita-container

Do not forget to set your git name and email:

    git config --global user.name "YOUR_NAME_HERE"
    git config --global user.email "YOUR_EMAIL_HERE"

### Building from the sources 📝

You will first need to build the docker image from the `Dockerfile`.

    docker build -t epita-container \
        --build-arg git_user_name="YOUR_NAME_HERE" \
        --build-arg git_user_email="YOUR_EMAIL_HERE" \
        "."

To run the docker container from the image, simply run:

    docker run -it docker.io/library/epita-container

### Default users 👬

There are two registered users in the container by default:

- `root` with password `root`
- `epita` with password `epita`

## VS Code here you are!

Visual Studio Code provides the ability to connect to a Docker container thanks to [this extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers). We are providing the `devcontainer.json` file. Feel free to add extensions, settings, mounts, etc.

Advice: because sharing a folder between your computer and the container drastically reduces I/O performance, use the `Clone Repository in Container Volume...` option when creating the container in VS Code. You will then have full I/O performance 😉

## Installed packages 📦

The list of all packages can be found in the `packages` file.

If you think a package is missing, please create an issue. We will be more than happy to discuss and to add it to 😉