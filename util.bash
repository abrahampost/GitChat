# utils for the gitchat-* scripts

die() {
  exit "${1:-1}"
}

err() {
  printf '%s\n' "$@" >&2
}

out() {
  printf '%\n' "$@"
}

verify_args() {
  if (( $# == 0 )) ; then
    err 'No repo name'
    die 1
  fi
  [[ "$1" =~ [^/]*/[^/]* ]]
}

# 1: org/repo
repo_name() {
  if (( $# == 0 )) ; then
    err 'No repo name'
    die 1
  fi
  printf '%s\n' ~/.chat/"$( dirname "$1" )-$( basename "$1" )"
}

# 1: org/repo
github_name() {
  if (( $# == 0 )) ; then
    err 'No repo name'
    die 1
  fi
  printf '%s\n' https://github.com/"$1"
}

# 1: org/repo
cd_repo() {
  if (( $# == 0 )) ; then
    err 'No repo name'
    die 1
  fi
  local dir
  dir="$(repo_name "$1")"
  if ! cd "$dir" ; then
    err "Cannot find $dir"
    die 1
  fi
}

# 1: org/repo
repo_exists() {
  if (( $# == 0 )) ; then
    err 'No repo name'
    die 1
  fi
  [[ -e "$(repo_name "$1")" ]]
}

# 1: org/repo
clone_repo() {
  if (( $# == 0 )) ; then
    err 'No repo name'
    die 1
  fi
  git clone --quiet "$(github_name "$1")" "$(repo_name "$1")"
}

setup() {
  verify_args "$@"
  if ! repo_exists "$1" ; then
    clone_repo "$1"
  fi
  cd_repo "$1"
}

username() {
  git config --get user.name | tr -d '[:space:]'
}

userfile() {
  out "$(username)".txt
}
