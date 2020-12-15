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

    docker run -it francoisdtm/epita-container:1.0

### Building from the sources 📝

You will first need to build the docker image from the `Dockerfile`.

    docker build -t epita-container:1.0 "."

To run the docker container from the image, simply run:

    docker run -it docker.io/library/epita-container:1.0

### Default users 👬

There are two registered users in the container by default:

- `root` with password `root`
- `epita` with password `epita`

## Installed packages 📦

The list of all packages can be found in the `packages` file.

If you think a package is missing, please create an issue. We will be more than happy to discuss and to add it to 😉