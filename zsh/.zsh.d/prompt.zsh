#!/usr/local/bin/zsh -e

: 'Make colors available'　&& {
  autoload -Uz colors
  colors
}

: 'prompt setting' && {
  # エスケープシーケンスを通るオプション
  setopt prompt_subst

  # 改行のない出力をプロンプトで上書きするのを防ぐ
  unsetopt promptcr
  getExpireTime

  # プロンプトの設定
  if [ "$(uname)" = 'Darwin' ]; then
    export PROMPT=$'%(?.😀 .😱 )%{\e[$[32+$RANDOM % 5]m%}❯%{\e[0m%}%{\e[$[32+$RANDOM % 5]m%}❯%{\e[0m%}%{\e[$[32+$RANDOM % 5]m%}❯%{\e[0m%} '
    export RPROMPT=$'$TIMER %{\e[30;48;5;237m%}%{\e[38;5;249m%} %D %* %{\e[0m%}'
  else
    export PROMPT=$'%{\e[$[32+$RANDOM % 5]m%}>%{\e[0m%}%{\e[$[32+$RANDOM % 5]m%}>%{\e[0m%}%{\e[$[32+$RANDOM % 5]m%}>%{\e[0m%} '
    export RPROMPT=$'$TIMER %{\e[38;5;001m%}%(?.(^_^).(x_x))%{\e[0m%} %{\e[30;48;5;237m%}%{\e[38;5;249m%} %D %* %{\e[0m%}'
  fi

  # プロンプト自動更新設定
  autoload -U is-at-least

  # $EPOCHSECONDS, strftime等を利用可能に
  zmodload zsh/datetime

  if is_osx ; then
    reset_tmout() {
      export TMOUT=10
    }
  else
    reset_tmout() {
      export TMOUT=10
    }
  fi

  precmd_functions=($precmd_functions reset_tmout reset_lastcomp)

  reset_lastcomp() {
    _lastcomp=()
  }

  if is-at-least 5.1; then
    # avoid menuselect to be cleared by reset-prompt
    redraw_tmout() {
      [ "$WIDGET" = "expand-or-complete" ] && [[ "$_lastcomp[insert]" =~ "^automenu$|^menu:" ]] || zle reset-prompt
      reset_tmout
    }
  else
    # evaluating $WIDGET in TMOUT may crash :(
    redraw_tmout() {
      zle reset-prompt; reset_tmout
    }
  fi

  TRAPALRM() {
    redraw_tmout
    getExpireTime
    zle reset-prompt
  }
}

precmd() {
  print
  autoload -Uz vcs_info
  autoload -Uz add-zsh-hook

  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
  zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+"
  local left=$'$(powerline-go --shell zsh $?)'
  local right=$'${vcs_info_msg_0_} '
  if is_osx; then
    zstyle ':vcs_info:*' formats '%F{green}%c%u[✔ %b]%f'
    zstyle ':vcs_info:*' actionformats '%F{red}%c%u[✑ %b|%a]%f'
  else
    zstyle ':vcs_info:*' formats '%F{green}%c%u{%r}-[%b]%f'
    zstyle ':vcs_info:*' actionformats '%F{red}%c%u{%r}-[%b|%a]%f'
  fi

  LANG=en_US.UTF-8 vcs_info

  local invisible='%([BSUbfksu]|([FK]|){*})'
  local leftwidth=${#${(S%%)left//$~invisible/}}
  local rightwidth=${#${(S%%)right//$~invisible/}}
  local padwidth=$(($COLUMNS - ($leftwidth + $rightwidth) % $COLUMNS))

  if is_osx; then
    print -P $left
  else
    print -P $left${(r:$padwidth:: :)}$right
  fi
}
