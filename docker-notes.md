#Install Docker on Ubuntu

https://docs.docker.com/engine/getstarted/linux_install_help/

#Getting started with Docker

Create and run new container using Ubuntu image:
```
docker run --name <name> -it ubuntu bash
```

Now once inside container, if you want to install packages, first need to run:

```
apt-get update
```

Some general set-up:
```
apt-get install sudo
adduser <username>
usermod -aG sudo <username>
su - <username>
```

Prepare container for `cmake` and `make` tutorials:
```
sudo apt-get install cmake make
```
Install either `emacs-nox` or `vim`. To exit docker container, just type `exit`.

We can create a new image from the container we've been playing in. Example:

```
docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
docker commit -m "Environment with cmake and make." thw
```

View this new image:
```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
<none>              <none>              63b712dc4b0a        19 seconds ago      520.4 MB
```

We can then spawn new containers from this image:
```
docker run -it --name learn-make 63b712dc4b0a
```

(If no command is explicitly appended to the image name, the `bash` command is
automatically assumed).

In the future, I need to learn about Dockerfiles as well as many other things!

#Useful Docker commands

To enter running container with new tty:
```
docker exec -it <container> bash
```

To enter into stopped docker container:

```
docker start -ai <container>
```

Can always get additional information about docker commands with:
```
docker <cmd> --help
```

List all containers on the system:
```
docker ps -a
```

Remove container (supply either ID or name):
```
docker rm <container>
```
Copy files from container to host:

```
docker cp <containerId>:/file/path/within/container /host/path/target
```
