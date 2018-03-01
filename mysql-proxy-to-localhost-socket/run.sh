#!/bin/bash
# Copyright (c) Andreas Urbanski, 2016
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Output colors
underline='\033[4;37m'
purple='\033[0;35m'
bold='\033[1;37m'
green='\033[0;32m'
cyan='\033[0;36m'
red='\033[0;31m'
nc='\033[0m'

# Find image id
image=$(docker images|grep mysql-proxy-to-localhost-socket|awk '{print $3}')

# Find agent container id
id=$(docker ps -a|grep mysql-proxy|awk '{print $1}')

# Stop command
if [ "$1" == "-s" ] && [ $id ]; then
  echo -e "Stopping mysql-proxy container..."
  docker rm -f $id
  exit
fi

# Build image if not available
if [ -z $image ]; then
  echo -e "${bold}The image for ssh-mysql-localhost-socket has not been built.${nc}"
  echo -e "Building image..."
  docker build -t mysql-proxy-to-localhost-socket:latest -f Dockerfile .
  echo -e "${cyan}Image built.${nc}"
fi

# If container is already running, exit.
if [ $id ]; then
  echo -e "A container named 'mysql-proxy' is already running."
  echo -e "Do you wish to stop it? (y/N): "
  read input

  if [ "$input" == "y" ]; then
    echo -e "Stopping mysql-proxy container..."
    docker rm -f $id
    echo -e "${red}Stopped.${nc}"
  fi

  exit
fi

# Run mysql-proxy
echo -e "${bold}Launching mysql-proxy container...${nc}"
docker run -d --name=mysql-proxy mysql-proxy-to-localhost-socket:latest

echo -e "${green}mysql-proxy is now ready to use.${nc}"
