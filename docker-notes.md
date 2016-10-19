#Install Docker on Ubuntu

https://docs.docker.com/engine/getstarted/linux_install_help/

##Complete Installation Instructions for Xenial 16.04

```
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
```

Open text editor with root privileges. Create file:
`/etc/apt/sources.list.d/docker.list`. Add this line:

```
deb https://apt.dockerproject.org/repo ubuntu-xenial main
```

Then:
```
sudo apt-get update
sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install docker-engine
sudo service docker start
```
Verify installation:
```
sudo docker run hello-world
```

Optional: create docker group so that docker commands don't have to be run with sudo
```
sudo groupadd docker
sudo usermod -aG docker $USER
```
Log out and log back in.
```
docker run hello-world
```
###Can get a ready-made cmake and make environment by running:
```
docker run -it --name learn-make lindsayad/thw:latest
```

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

Let's assign the image some human-readable name:
```
docker tag 63b712dc4b0a lindsayad/thw:latest
```

where `lindsayad/thw` indicates the user is `lindsayad` and the repository is
`thw`, and the tag is `latest`. Example use of tags: the ubuntu repository has
`16.04`, `14.04`, `12.04` tags etc. When pulling an image, if a tag is not
specified, it defaults to `latest`.

We can then spawn new containers from this image:
```
docker run -it --name learn-make lindsayad/thw:latest
```

(If no command is explicitly appended to the image name, the `bash` command is
automatically assumed).

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
