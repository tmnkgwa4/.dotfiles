#!/usr/local/bin/zsh -e

: 'Configuration for common' && {
  # - コマンド訂正
  # - beep音を無効化
  # - バックグラウンドジョブが終了したらすぐに知らせる
  # - cd したら自動的にpushdする
  # - ディレクトリ名だけでcdする
  # - '#' 以降をコメントとして扱う
  # - Ctrl+Dでログアウトしてしまうことを防ぐ
  # - flow controlを無効化する
  # - 高機能なワイルドカード展開を使用する
  # - 日本語ファイル名を表示可能にする
  # - 重複したディレクトリを追加しない
  setopt correct
  setopt no_beep
  setopt notify
  setopt auto_pushd
  setopt auto_cd
  setopt interactive_comments
  setopt ignoreeof
  setopt no_flow_control
  setopt extended_glob
  setopt print_eight_bit
  setopt pushd_ignore_dups

  # - ファイルマークの削除
  unsetopt list_types
}

: 'Configuration for history' && {
  # - 同時に起動したzshの間でヒストリを共有する
  # - 同じコマンドをヒストリに残さない
  # - スペースから始まるコマンド行はヒストリに残さない
  # - ヒストリに保存するときに余分なスペースを削除する
  # - zsh の開始, 終了時刻をヒストリファイルに書き込む
  # - shellの終了を待たずにファイルにコマンド履歴を保存
  setopt share_history
  setopt hist_ignore_all_dups
  setopt hist_ignore_space
  setopt hist_reduce_blanks
  setopt extended_history
  setopt inc_append_history
}
