# Oh-My-Zsh Theme
ZSH_THEME="spaceship"
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="> "
SPACESHIP_CHAR_SYMBOL_ROOT="$ "
SPACESHIP_DIR_TRUNC=0
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_EXIT_CODE_SYMBOL=""
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  exec_time     # Execution time
  line_sep      # Line break
  exit_code     # Exit code section
  char          # Prompt character
)

# Some Config
DISABLE_UPDATE_PROMPT="true"
UPDATE_ZSH_DAYS=1
DISABLE_MAGIC_FUNCTIONS=true
plugins=(
    git
    gitignore
    zsh-syntax-highlighting
    zsh-autosuggestions
    git-auto-fetch
    z
)

# Colored man pages
export LESS_TERMCAP_mb=$'\e[1;33m'
export LESS_TERMCAP_md=$'\e[1;95m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;94m'

# Load Oh-My-Zsh
source /home/epita/.oh-my-zsh/oh-my-zsh.sh

# Directories aliases
alias d='dirs -v | head -10'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
