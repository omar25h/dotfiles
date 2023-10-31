set -gx GOENV_ROOT $HOME/.goenv
fish_add_path $GOENV_ROOT/bin

if status --is-interactive
  source (goenv init - | psub)
end
