# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh configuration.
export ZSH="$HOME/.oh-my-zsh"

# add local bin
export PATH=$HOME/.local/bin:$PATH

# editor
export EDITOR=nvim

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  gh
  history
  git
  dotenv
  fzf
  pyenv
  python
  docker
  aws
  golang
  npm
  nvm
  terraform
  tmux
  zsh-autosuggestions
  zsh-syntax-highlighting
  fast-syntax-highlighting
  zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# gpg setup
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# zoxide
eval "$(zoxide init zsh)"

# aliases
[[ -f ~/.aliases.zsh ]] && source ~/.aliases.zsh

# custom functions
[[ -f ~/.functions.zsh ]] && source ~/.functions.zsh
