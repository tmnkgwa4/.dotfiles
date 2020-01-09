#!/bin//zsh -e

: 'env vars for path' && {
  VERSION=1.13.5
  ARCH=amd64
  GOPATH=${HOME}/go
  if is_osx; then
    OS=darwin
  elif is_linux; then
    0S=linux
  fi
  if [ ! -e ${GOPATH} ]; then
    curl -o /var/tmp/go.tar.gz -L https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz
    tar -C ${GOHOME} -xzf /var/tmp/go.tar.gz
    rm -rf /var/tmp/go.tar.gz
  fi
  export PATH=/usr/local/opt/inetutils/libexec/gnubin:${PATH}
  export PATH=${GOPATH}/bin:${PATH}
}
