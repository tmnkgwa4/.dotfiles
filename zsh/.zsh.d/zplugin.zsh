#!/usr/local/bin/zsh -e

: 'global setting' && {
  autoload -Uz _zplugin
  ((${+_comps})) && _comps[zplugin]=_zplugin
}

: 'zplugin module' && {
  # completion
  zplugin ice wait'0'; zplugin load zsh-users/zsh-completions
  zplugin ice wait'0'; zplugin load zsh-users/zsh-autosuggestions
  zplugin ice wait'0'; zplugin load glidenote/hub-zsh-completion
  zplugin ice wait'0'; zplugin load Valodim/zsh-curl-completion
  zplugin ice wait'0'; zplugin load docker/cli
  zplugin ice wait'0'; zplugin load nnao45/zsh-kubectl-completion
  zstyle ':completion:*:*:kubectl:*' list-grouped false

  # coloring
  zplugin load chrissicool/zsh-256color
  zplugin load zsh-users/zsh-syntax-highlighting

  # expanding aliases
  zplugin load momo-lab/zsh-abbrev-alias

  # emoji
  if (($+commands[jq])); then
    zplugin ice wait'0'; zplugin load b4b4r07/emoji-cli
  fi

  # Find and display frequently used displays
  zplugin load rupa/z
}
