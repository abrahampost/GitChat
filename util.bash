# utils for the gitchat-* scripts

die() {
  exit "${1:-1}"
}

err() {
  printf '%s\n' "$@" >&2
}

out() {
  printf '%s\n' "$@"
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
  verify_args "$@"
  printf '%s\n' ~/.chat/"$( dirname "$1" )-$( basename "$1" )"
}

# 1: org/repo
github_name() {
  verify_args "$@"
  printf '%s\n' https://github.com/"$1"
}

# 1: org/repo
cd_repo() {
  verify_args "$@"
  local dir
  dir="$(repo_name "$1")"
  if ! cd "$dir" ; then
    err "Cannot find $dir"
    die 1
  fi
}

# 1: org/repo
repo_exists() {
  verify_args "$@"
  [[ -e "$(repo_name "$1")" ]]
}

# 1: org/repo
clone_repo() {
  verify_args "$@"
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
