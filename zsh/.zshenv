: 'configuration for zplugin' && {
  autoload -Uz compinit
  compinit
}

: 'debug settings' && {
  # true  = debug mode
  # false = non debug mode
  export ZSH_DEBUG=false
}

: 'load zprof' && {
  if $ZSH_DEBUG; then
    zmodload zsh/zprof && zprof
  fi
}
