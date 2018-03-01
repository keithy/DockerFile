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

# Print a debug message if debug mode is on ($DEBUG is not empty)
# @param message
debug_msg ()
{
  if [ -n "$DEBUG" ]; then
    echo "$@"
  fi
}

case "$1" in
  # Start mysql-socket
  mysql-proxy)

  # Create socket for mysql-proxy  
  echo "Creating a proxy socket... (with permissions)"
  
  mkdir -p ${MYSQL_SOCKET_DIR} 2>&1
  rm ${MYSQL_SOCKET} > /dev/null 2>&1
  sleep 2 ; chmod 777 ${MYSQL_SOCKET} &
  
  ssh -4Nx -L${MYSQL_SOCKET}:localhost:${MYSQL_PORT} ${MYSQL_USER} ${MYSQL_HOST}

  ;;
	*)
  exec $@
  ;;
esac
