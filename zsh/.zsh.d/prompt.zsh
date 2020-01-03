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

  # プロンプトの設定
  if [ "$(uname)" = 'Darwin' ]; then
    export PROMPT=$'%(?.😀 .😱 )%{\e[$[32+$RANDOM % 5]m%}❯%{\e[0m%}%{\e[$[32+$RANDOM % 5]m%}❯%{\e[0m%}%{\e[$[32+$RANDOM % 5]m%}❯%{\e[0m%} '
    export RPROMPT=$'%{\e[38;5;001m%}%(?..✘☝)%{\e[0m%} %{\e[30;48;5;237m%}%{\e[38;5;249m%} %D %* %{\e[0m%}'
  else
    export PROMPT=$'%{\e[$[32+$RANDOM % 5]m%}>%{\e[0m%}%{\e[$[32+$RANDOM % 5]m%}>%{\e[0m%}%{\e[$[32+$RANDOM % 5]m%}>%{\e[0m%} '
    export RPROMPT=$'%{\e[30;48;5;237m%}%{\e[38;5;249m%} %D %* %{\e[0m%}'
  fi

  # プロンプト自動更新設定
  autoload -U is-at-least

  # $EPOCHSECONDS, strftime等を利用可能に
  zmodload zsh/datetime

  if [[ "$(uname)" = 'Darwin' ]] ; then
    reset_tmout() {
      export TMOUT=$[1-EPOCHSECONDS%1]
    }
  else
    reset_tmout() {
      export TMOUT=$[30-EPOCHSECONDS%30]
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
  }
}

precmd() {
  print
  autoload -Uz vcs_info
  autoload -Uz add-zsh-hook

  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
  zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+"
  zstyle ':vcs_info:*' formats '%F{green}%c%u{%r}-[%b]%f'
  zstyle ':vcs_info:*' actionformats '%F{red}%c%u{%r}-[%b|%a]%f'

  local left=$'%{\e[38;5;083m%}%n%{\e[0m%} %{\e[$[32+$RANDOM % 5]m%}➜%{\e[0m%} %{\e[38;5;051m%}%d%{\e[0m%}'
  local right="${vcs_info_msg_0_} "

  LANG=en_US.UTF-8 vcs_info

  # スペースの長さを計算
  # テキストを装飾する場合、エスケープシーケンスをカウントしないようにする
  local invisible='%([BSUbfksu]|([FK]|){*})'
  local leftwidth=${#${(S%%)left//$~invisible/}}
  local rightwidth=${#${(S%%)right//$~invisible/}}
  local padwidth=$(($COLUMNS - ($leftwidth + $rightwidth) % $COLUMNS))
  print -P $left${(r:$padwidth:: :)}$right
}
