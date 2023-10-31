set -gx LESS "--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4"

set -gx LESS_TERMCAP_mb \e'[1;31m'     # begin bold
set -gx LESS_TERMCAP_md \e'[1;36m'     # begin blink
set -gx LESS_TERMCAP_me \e'[0m'        # reset bold/blink
set -gx LESS_TERMCAP_so \e'[01;44;33m' # begin reverse video
set -gx LESS_TERMCAP_se \e'[0m'        # reset reverse video
set -gx LESS_TERMCAP_us \e'[1;32m'     # begin underline
set -gx LESS_TERMCAP_ue \e'[0m'        # reset underline
