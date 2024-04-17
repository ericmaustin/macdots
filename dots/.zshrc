# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh configuration.
export ZSH="$HOME/.oh-my-zsh"

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

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias ....="cd ../../.."
alias ...="cd ../.."
alias ..="cd .."
alias c="clear"
alias d="eza --icons -D"
alias dl="docker ps -a"
alias dli="docker images"
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gba="git branch -a"
alias gc="git commit"
alias gcm="git commit -m"
alias gco="git checkout"
alias gd="git diff"
alias gdca="git diff --cached"
alias gdct="git describe --tags $\(git rev-list --tags --max-count=1\)"
alias gdcw="git diff --cached --word-diff"
alias gds="git diff --staged"
alias gf="git fetch"
alias gfa="git fetch --all"
alias gft="git fetch --tags"
alias gl="git log"
alias glb="git log --graph --oneline --decorate --all"
alias glc="git log --graph --oneline --decorate --all --color"
alias glcb="git log --graph --oneline --decorate --all --color --branches"
alias glcp="git log --graph --oneline --decorate --all --color --patch"
alias glcpb="git log --graph --oneline --decorate --all --color --patch --branches"
alias glcpr="git log --graph --oneline --decorate --all --color --patch --remotes"
alias glcprb="git log --graph --oneline --decorate --all --color --patch --remotes --branches"
alias glg="git log --graph --oneline --decorate"
alias glo="git log --oneline"
alias glog="git log --oneline --graph"
alias gloga="git log --oneline --graph --all"
alias glp="git log --graph --oneline --decorate --patch"
alias gm="git merge"
alias gp="git push"
alias gpd="git push --dry-run"
alias gpf="git push --force"
alias gpl="git pull"
alias gpt="git push --tags"
alias gr="git rebase"
alias grep="grep --color=auto"
alias gs="git status"
alias gup="git pull --rebase"
alias h="helm"
alias header="curl -I"
alias k="kubectl"
alias kn="kubens"
alias kx="kubectx"
alias la="eza --icons -a"
alias lg="eza --icons --git"
alias ll="eza --icons -l"
alias ls="eza --icons"
alias md5="openssl md5"
alias sha1="openssl sha1"
alias sha256="openssl sha -sha256"
alias sha512="openssl sha -sha512"
alias tf="terraform"
alias tg="terragrunt"
alias v="nvim"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "${method}"="lwp-request -m '${method}'"
done

# gpg setup
export GPG_TTY=$(tty)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
