#!/usr/local/bin/fish
alias tmux='/usr/local/bin/tmux'

if ! tmux has-session; and test "$argv" != "tmux.conf"
    exit
end

set -l MODE $(defaults read -g AppleInterfaceStyle 2>&1)

if test "$MODE" = "Dark"
  set COLOUR_STATUS_BG "#3a3735"
  set COLOUR_PREFIX_ACTIVE_BG "#d65d0e"
  set COLOUR_PREFIX_ACTIVE_FG "#3a3735"
  set COLOUR_PREFIX_INACTIVE_BG "#a89984"
  set COLOUR_PREFIX_INACTIVE_FG "#3b4252"
  set COLOUR_ACTIVE_WINDOW_BG "#98971a"
  set COLOUR_ACTIVE_WINDOW_FG "#3a3735"
  set COLOUR_INACTIVE_WINDOW_BG "#7c6f64"
  set COLOUR_INACTIVE_WINDOW_FG "#3c3836"
  set COLOUR_MESSAGE_BG "#fabd2f"
  set COLOUR_MESSAGE_FG "#504945"
  set COLOUR_ACTIVE_PANE "#fe8019"
  set COLOUR_INACTIVE_PANE "#504945"
else
  set COLOUR_STATUS_BG "#d5c4a1"
  set COLOUR_PREFIX_ACTIVE_BG "#d65d0e"
  set COLOUR_PREFIX_ACTIVE_FG "#3C3836"
  set COLOUR_PREFIX_INACTIVE_BG "#A89984"
  set COLOUR_PREFIX_INACTIVE_FG "#3C3836"
  set COLOUR_ACTIVE_WINDOW_BG "#98971a"
  set COLOUR_ACTIVE_WINDOW_FG "#3a3735"
  set COLOUR_INACTIVE_WINDOW_BG "#bdae93"
  set COLOUR_INACTIVE_WINDOW_FG "#504945"
  set COLOUR_MESSAGE_BG "#b57614"
  set COLOUR_MESSAGE_FG "#ebdbb2"
  set COLOUR_ACTIVE_PANE "#af3a03"
  set COLOUR_INACTIVE_PANE "#d5c4a1"
end

tmux set -g status-style "none,bg=$COLOUR_STATUS_BG"

tmux setw -g window-status-style "none,fg=$COLOUR_INACTIVE_WINDOW_FG,bg=$COLOUR_STATUS_BG"
tmux setw -g window-status-activity-style "underscore,fg=#a89984,bg=$COLOUR_STATUS_BG"

tmux setw -g window-status-format "#[bg=$COLOUR_INACTIVE_WINDOW_BG,fg=$COLOUR_STATUS_BG,nobold,nounderscore,noitalics]#[fg=$COLOUR_INACTIVE_WINDOW_FG,bg=$COLOUR_INACTIVE_WINDOW_BG,bold] #I  #W #{p-2:window_flags} #[fg=$COLOUR_INACTIVE_WINDOW_BG,bg=$COLOUR_STATUS_BG,nobold,nounderscore,noitalics]"

tmux setw -g window-status-current-format "#[bg=$COLOUR_ACTIVE_WINDOW_BG,fg=$COLOUR_STATUS_BG,nobold,nounderscore,noitalics]#[fg=$COLOUR_ACTIVE_WINDOW_FG,bg=$COLOUR_ACTIVE_WINDOW_BG,bold] #I  #W #{p-2:window_flags} #[fg=$COLOUR_ACTIVE_WINDOW_BG,bg=$COLOUR_STATUS_BG,nobold,nounderscore,noitalics]"

tmux set -g status-left "#{?client_prefix,#[fg=$COLOUR_PREFIX_ACTIVE_FG#,bg=$COLOUR_PREFIX_ACTIVE_BG],#[fg=$COLOUR_PREFIX_INACTIVE_FG#,bg=$COLOUR_PREFIX_INACTIVE_BG]}#[bold] #S #{?client_prefix,#[fg=$COLOUR_PREFIX_ACTIVE_BG],#[fg=$COLOUR_PREFIX_INACTIVE_BG]}#[bg=$COLOUR_STATUS_BG]"

tmux set -g status-right ""

tmux set -g message-style "fg=$COLOUR_MESSAGE_FG,bg=$COLOUR_MESSAGE_BG"
tmux set -g message-command-style "fg=$COLOUR_MESSAGE_FG,bg=$COLOUR_MESSAGE_BG"
tmux set -g pane-border-style "fg=$COLOUR_INACTIVE_PANE,bg=default"
tmux set -g pane-active-border-style "fg=$COLOUR_ACTIVE_PANE,bg=default"
