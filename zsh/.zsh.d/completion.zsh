#!/usr/local/bin/zsh -e

: 'Configuration for completion' && {
  # - 単語の途中でもカーソル位置で補完
  # - 補完候補を詰めて表示する
  # - 括弧の対応などを自動的に補完
  # - カーソル位置は保持したままファイル名一覧を順次その場で表示
  setopt complete_in_word
  setopt list_packed
  setopt auto_param_keys
  setopt always_last_prompt
}

: 'Configuration for zstyle' && {
  # 補完数が多い場合に表示されるメッセージの表示を1000にする。
  # 単語の区切り文字を指定する
  # 補完候補の色づけ
  export LISTMAX=1000
  export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
  export LSCOLORS=gxfxcxdxbxegedabagacad
  export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

  # - コマンドのオプションの説明を表示
  # - 補完のリストについてはlsと同じ表示色を使う
  # - 補完するときのフォーマットを拡張し指定する(http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Prompt-Expansion)
  # - 補完グループのレイアウトをいい感じにする。
  # - 補完のキャッシュを有効にする
  # - kubectlのキャッシュは有効にする
  # - 補完で小文字でも大文字にマッチさせる
  # - '../' の後は今いるディレクトリを補完しない
  # - sudo の後ろでコマンド名を補完する
  # - kill の候補にも色付き表示
  # - ps コマンドのプロセス名補完
  # - 選択中の候補を塗りつぶす
  zstyle ':completion:*' verbose yes
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*' format '%B%d%b'
  zstyle ':completion:*' group-name ''
  zstyle ':completion:*' use-cache true
  zstyle ':completion:*:*:kubectl:*' use-cache false
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
  zstyle ':completion:*' ignore-parents parent pwd ..
  zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
    /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
  zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
  zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
  zstyle ':completion:*:default' menu select=2

  # aws-cli コマンドの補完機能有効化
  if (($+commands[aws])); then
    AWSCLI=$(dirname $(which aws))
    source $AWSCLI/aws_zsh_completer.sh
  fi
}
