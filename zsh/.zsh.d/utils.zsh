#!/usr/local/bin/zsh -e

function copy_str() {
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

function lower() {
  copy_str | tr "[:upper:]" "[:lower:]"
}

function upper() {
  copy_str | tr "[:lower:]" "[:upper:]"
}

function ostype() {
  uname | lower
}

function os_detect() {
  export PLATFORM
  case "$(ostype)" in
  *'linux'*) PLATFORM='linux' ;;
  *'darwin'*) PLATFORM='osx' ;;
  *) PLATFORM='unknown' ;;
  esac
}

function is_osx() {
  os_detect
  if [[ ${PLATFORM} = "osx" ]]; then
    return 0
  else
    return 1
  fi
}

function is_linux() {
  os_detect
  if [[ ${PLATFORM} = "linux" ]]; then
    return 0
  else
    return 1
  fi
}
