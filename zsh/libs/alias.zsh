#!/usr/local/bin/zsh -e

: 'Global alias' && {
  # color setting
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'

  alias rm='rm -i'
  alias cp='cp -i'
  alias mv='mv -i'
  alias mkdir='mkdir -p'
  alias tf='terraform'
}

: 'alias for ls or exa' && {
  if (($+commands[exa])); then
    alias ls="exa -F"
    alias ll="exa -hlBFS"
    alias ld="exa -ld"
    alias la="exa -aF"
  else
    alias ls="ls -F"
    alias ll="ls -hlS"
    alias ld="echo 'Not found ld command.'"
    alias la="ls -la"
  fi
}

: 'alias for tmux' && {
  if (($+commands[tmux])); then
    alias t='tmux new -s "$(date +%Y-%m-%d_%H-%M-%S)"'
    alias tl='tmux ls'
  fi
}

: 'alias for git' && {
  if (($+commands[git])); then
    alias ga='git add'
    alias gc='git commit -m'
    alias gp='git push'
  fi
}

: 'alias for kubernetes config' && {
  if (($+commands[kubectl])); then
    alias k='kubectl'
    alias ka='kubectl apply'
    alias kd='kubectl delete'
    alias kcr='export KUBECONFIG="$HOME/.kube-raspi/config"'
    alias kcg='export KUBECONFIG="$HOME/.kube-gke/config"'
  fi
}

: 'alias for vim' && {
  alias vi='vim'
  alias view='vim -R'
}
