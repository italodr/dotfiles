source "${HOME}/.exports"
source "${HOME}/.inputrc"
source "${HOME}/.bash/git-aware-prompt/main.sh"

. "/usr/local/opt/nvm/nvm.sh" --no-use

export PS1="\W \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]$ "
