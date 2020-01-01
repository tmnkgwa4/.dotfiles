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
  export LANG='${LANGUAGE}'
  export LC_ALL='${LANGUAGE}'
  export LC_TYPE='${LANGUAGE}'
}

: 'env vars for path' && {
  export PATH=/usr/local/opt/inetutils/libexec/gnubin:${PATH}
  export PATH=$(go env GOPATH)/bin:${PATH}
}

: 'env vars for editor' && {
  export EDITOR=vim
}

: 'env vars for man' && {
  export MANPATH=/usr/local/opt/inetutils/libexec/gnuman:${MANPATH}
}
