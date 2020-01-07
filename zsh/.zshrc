#!/bin/zsh

: "Load myfunction files." && {
  source $HOME/.zsh.d/utils.zsh
}

: "Load zplugin files" && {
  if (($+commands[zplugin] == 1)); then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
  fi
  source $HOME/.zplugin/bin/zplugin.zsh
  source $HOME/.zsh.d/zplugin.zsh
}

: "Load environment files." && {
  source $HOME/.zsh.d/env.zsh
}

: "Load prompt files." && {
  source $HOME/.zsh.d/prompt.zsh
}

: "Load zsh option files." && {
  source $HOME/.zsh.d/option.zsh
}

: "Load zsh completion files." && {
  source $HOME/.zsh.d/completion.zsh
}

: "Load alias files." && {
  source $HOME/.zsh.d/alias.zsh
}

: "Output infomation of zsh startup time" && {
  if $ZSH_DEBUG; then
    zprof | head
  fi
}
