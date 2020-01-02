#!/usr/local/bin/zsh -e

: 'global setting' && {
  source $ZPLUG_HOME/init.zsh
}

: 'zplug module' && {
  # zplug integrations
  zplug "zplug/zplug", hook-build:"zplug --self-manage"

  # completion
  zplug "zsh-users/zsh-completions", as:plugin
  zplug "zsh-users/zsh-autosuggestions", as:plugin
  zplug "glidenote/hub-zsh-completion", as:plugin
  zplug "Valodim/zsh-curl-completion", as:plugin
  zplug "docker/cli", use:"contrib/completion/zsh/_docker", lazy:true
  zplug "nnao45/zsh-kubectl-completion", lazy:true
  zstyle ':completion:*:*:kubectl:*' list-grouped false

  # coloring
  zplug "chrissicool/zsh-256color", as:plugin
  zplug "zsh-users/zsh-syntax-highlighting", defer:2, as:plugin

  # expanding aliases
  zplug "momo-lab/zsh-abbrev-alias", as:plugin

  # emoji
  zplug "b4b4r07/emoji-cli", if:"which jq"

  # Find and display frequently used displays
  zplug "rupa/z", use:"*.sh", as:plugin

  # enhance change directory
  zplug "b4b4r07/enhancd", use:"enhancd.sh"
}

: 'zplug install check' && {
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi
  zplug load
}
