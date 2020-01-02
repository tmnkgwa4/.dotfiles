#!/usr/local/bin/zsh -e

copy_str() {
  if [[ $# -eq 0 ]]; then
    cat <&0
  elif [[ $# -eq 1 ]]; then
    if [[ -f "$1" ]] && [[ -r "$1" ]]; then
      cat "$1"
    else
      echo "$1"
    fi
  else
    return 1
  fi
}

lower() {
  copy_str | tr "[:upper:]" "[:lower:]"
}

upper() {
  copy_str | tr "[:lower:]" "[:upper:]"
}

ostype() {
  uname | lower
}

os_detect() {
  export PLATFORM
  case "$(ostype)" in
  *'linux'*) PLATFORM='linux' ;;
  *'darwin'*) PLATFORM='osx' ;;
  *) PLATFORM='unknown' ;;
  esac
}

is_osx() {
  os_detect
  if [[ ${PLATFORM} = "osx" ]]; then
    return 0
  else
    return 1
  fi
}

is_linux() {
  os_detect
  if [[ ${PLATFORM} = "linux" ]]; then
    return 0
  else
    return 1
  fi
}
