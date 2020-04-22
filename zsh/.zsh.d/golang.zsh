#!/bin/zsh -e

if is_osx; then
  GOOS=darwin
elif is_linux; then
  GO0S=linux
fi

function exists() {
  (( ${+commands[$1]} ))
}

function logging(){
  echo "Start install: " $1
}

function golangenvdestroy() {
  sudo rm -rf ${GOPATH} /usr/local/go
}

: 'load env' && {
  export GOPATH=${HOME}/go
  export PATH=${PATH}:/usr/local/opt/inetutils/libexec/gnubin:/usr/local/go/bin:${GOPATH}/bin::/usr/local/go/bin/kubebuilder/bin
  export GOARCH=$(go env GOARCH)
  export GO111MODULE=on
}

: 'install golang' && {
  GOVERSION=1.13.10
  GOARCH=amd64
  if ! exists go; then
    logging go
    curl -o /tmp/go.tar.gz -L https://dl.google.com/go/go${GOVERSION}.${GOOS}-${GOARCH}.tar.gz
    sudo tar -xzf /tmp/go.tar.gz -C /usr/local
    rm -rf /tmp/go.tar.gz
    mkdir -p ${GOPATH}/src ${GOPATH}/bin ${GOPATH}/pkg
  fi
}

: 'install Kubernetes in Docker' && {
  KINDVERSION=v0.6.1
  KINDARCH=amd64
  if ! exists kind; then
    logging kind
    curl -Lo ./kind "https://github.com/kubernetes-sigs/kind/releases/download/${KINDVERSION}/kind-$(uname)-${KINDARCH}"
    chmod +x ./kind
    sudo mv ./kind /usr/local/go/bin/kind
  fi
}

: 'install dep' && {
  if ! exists dep; then
    logging dep
    curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
  fi
}

: 'install kustomize' && {
  KUSTOMIZE_VERSION=3.1.0
  if ! exists kustomize; then
    logging kustomize
    curl -Lo ./kustomize https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_${GOOS}_amd64
    chmod +x ./kustomize
    sudo mv ./kustomize /usr/local/go/bin/kustomize
  fi
}

: 'install kubebuilder' && {
  if is_osx; then
    GOOS=darwin
  elif is_linux; then
    GO0S=linux
  fi
  KUBEBUILDER_VERSION=2.3.1

  if ! exists kubebuilder; then
    logging kubebuilder
    # download kubebuilder and extract it to tmp
    curl -L https://go.kubebuilder.io/dl/${KUBEBUILDER_VERSION}/${GOOS}/${GOARCH} | tar -xz -C /tmp/

    # move to a long-term location and put it on your path
    # (you'll need to set the KUBEBUILDER_ASSETS env var if you put it somewhere else)
    sudo mv /tmp/kubebuilder_${KUBEBUILDER_VERSION}_${GOOS}_${GOARCH} /usr/local/go/bin/kubebuilder
  fi
}
