#!/bin//zsh -e

: 'env vars for path' && {
  GOVERSION=1.13.5
  GOARCH=amd64
  GOPATH=${HOME}/go
  if is_osx; then
    GOOS=darwin
  elif is_linux; then
    GO0S=linux
  fi
  if [ ! -e "${GOPATH}/bin" ]; then
    curl -o /var/tmp/go.tar.gz -L https://dl.google.com/go/go$GOVERSION.$GOOS-$GOARCH.tar.gz
    tar -xzf /var/tmp/go.tar.gz -C ${HOME}
    rm -rf /var/tmp/go.tar.gz
  fi
  export PATH=/usr/local/opt/inetutils/libexec/gnubin:${PATH}
  export PATH=${GOPATH}/bin:${PATH}
}

: 'install Kubernetes in Docker' && {
  KINDVERSION=v0.6.1
  KINDARCH=amd64
  if [ ! -e "${GOPATH}/bin/kind" ]; then
    curl -Lo ./kind "https://github.com/kubernetes-sigs/kind/releases/download/${KINDVERSION}/kind-$(uname)-${KINDARCH}"
    chmod +x ./kind
    mv ./kind $GOPATH/bin/kind
  fi
}
