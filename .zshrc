autoload -U promptinit; promptinit
prompt pure

source "${HOME}/.exports"
source "${HOME}/.aliases"
source "${HOME}/.vimrc"
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

. "/usr/local/opt/nvm/nvm.sh" --no-use
