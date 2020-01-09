: 'env vars for global' && {
  export DOTZSH_HOME=${HOME}/zsh
}

: 'env vars for zplug' && {
  export ZPLUG_HOME=/usr/local/opt/zplug
  if [ ! -e ${ZPLUG_HOME} ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  fi
}

: 'env vars for history' && {
  export HISTFILE=${HOME}/.zsh_history
  export HISTSIZE=1000
  export SAVEHIST=100000
}

: 'env vars for locale & timezone' && {
  export TZ='Asia/Tokyo'
  export LANGUAGE='ja_JP.UTF-8'
  export LANG=${LANGUAGE}
  export LC_ALL=${LANGUAGE}
  export LC_TYPE=${LANGUAGE}
}

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

: 'env vars for editor' && {
  export EDITOR=vim
}

: 'env vars for man' && {
  export MANPATH=/usr/local/opt/inetutils/libexec/gnuman:${MANPATH}
}

: 'env compilation' && {
  # 補完数が多い場合に表示されるメッセージの表示を1000にする。
  export LISTMAX=1000

  # 単語の区切り文字を指定する
  export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
}
