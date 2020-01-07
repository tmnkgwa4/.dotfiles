#!/bin/zsh -e

: 'setup environment' && {
  export DOTPATH=$(pwd)
  mkdir ~/.zsh.d
}

: 'install zshrc' && {
  ln -s $DOTPATH/zsh/.zshrc ~/.zshrc
  for FILE in $(find $DOTPATH/zsh/.zsh.d -type f);
  do
    FILENAME=$(basename $FILE)
    echo load $FILENAME ...
    ln -s $DOTPATH/zsh/.zsh.d/$FILENAME ~/.zsh.d/$FILENAME
  done
}
