if status --is-interactive
  fnm env --use-on-cd --log-level=quiet | source
  starship init fish | source
  zoxide init fish | source

  if test -z "$NVIM"
    fish_vi_key_bindings
  end
end

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.local/share/bob/nvim-bin
fish_add_path $HOME/Library/Python/3.9/bin

fish_add_path /usr/local/sbin
fish_add_path /usr/local/texlive/2021/bin/universal-darwin
fish_add_path /usr/local/opt/coreutils/libexec/gnubin
fish_add_path /usr/local/opt/make@4.3/libexec/gnubin
fish_add_path /usr/local/opt/gnu-sed/libexec/gnubin
fish_add_path /usr/local/opt/findutils/libexec/gnubin
fish_add_path /usr/local/opt/grep/libexec/gnubin
fish_add_path /usr/local/opt/llvm/bin
fish_add_path /usr/local/opt/curl/bin

set -gx EDITOR $HOME/.local/share/bob/nvim-bin/nvim
set -gx DOCKER_HOST "unix://$HOME/.colima/default/docker.sock"
set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/ripgreprc

alias portlisten="netstat -anvp tcp | awk 'NR<3 || /LISTEN/'"

alias ls="eza"
alias lt="eza -T --color=always --group-directories-first --icons"
alias ll="eza -lh"

alias urlencode='python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1] if len(sys.argv) > 1 else sys.stdin.read()[0:-1], safe=\"\"))"'
alias urldecode='python3 -c "import urllib.parse, sys; print(urllib.parse.unquote(sys.argv[1] if len(sys.argv) > 1 else sys.stdin.read()[0:-1]))"'

# TMUX exports the original values of the fields when the session is created,
# thus leaving the exported values in an outdated state. This makes sure that
# only the universal values of the following environment variables are used.
set -eg DARKMODE
set -eg BAT_THEME
