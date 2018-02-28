# Docker Mysql Proxy to localhost socket via ssh

Lets you provide a "localhost" socket for your containers to remotely access mysql databases. 
Works in OSX and Linux environments.

## Why?

If serving code that expects MySQL to be available at via a socket on "localhost" this provides
a basic proxy which can be directed at any remote server accessible via ssh

## hub.docker.com

You can pull the image from [DockerHub](https://hub.docker.com/r/keithy/mysql-proxy-to-localhost-socket) via

```
docker pull keithy/mysql-proxy-to-localhost-socket
```

## How to use

### Quickstart

To get up and running super fast, run the `run.sh` script which will build the images for you, and launch the mysql-proxy.

Launch everything:

```
./run.sh
```
### Step by step

#### 0. Build
Navigate to the project directory and launch the following command to build the image:

```
docker build -t keithy/mysql-proxy-to-localhost-socket:latest -f Dockerfile .
```

#### 1. Run the mysql-proxy as a background daemon
```
docker run -d --name=mysql-proxy mysql-proxy-to-localhost-socket:latest
```

#### 3. Add mysql-proxy socket to other container:

If you're using `docker-compose` this is how you forward the socket to a container:

```
  volumes_from:
    - mysql-proxy
  environment:
    - MYSQL_SOCKET=/var/run/mysqld/mysqld.sock
```

 

##### Without docker-compose
Here's an example how to run a Ubuntu container that uses the ssh authentication socket:
```
docker run -it --volumes-from=mysql-proxy -e MYSQL_SOCKET=/var/run/mysqld/mysqld.sock ubuntu:latest /bin/bash
```
