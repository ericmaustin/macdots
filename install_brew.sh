#! /bin/env bash
PACKAGES=(
  # prerequisites
  openssl
  utm
  gpg
  gdb
  coreutils
  moreutils

  # mac improvements
  alt-tab

  # browsers
  firefox
  google-chrome

  # media
  spotify

  # messaging
  zoom
  slack
  signal

  # editors and terminals
  neovim
  tmux
  warp

  # cloud providers and tools
  awscli
  azure-cli
  google-cloud-sdk
  granted

  # cli and terminal tools
  eza
  jq
  yq
  fzf
  ripgrep
  tree
  screen
  pinentry-mac

  # lua
  lua
  luarocks
  lua-language-server
  stylua

  # c/c++
  gcc
  cmake
  llvm
  clang
  ccls
  cppcheck
  cquery
  ctags
  cscope

  # rust
  rust
  rustup
  rust-analyzer
  cmake

  # containers
  docker
  orbstack
  helm
  k9s
  krew
  kubectx
  kubens
  kubernetes-cli
  kustomize
  coreutils

  # javascript & typescript
  node
  nvm
  npm
  eslint

  # golang
  go
  gofumpt
  gopls
  golangci-lint

  # python
  pyenv
  pyenv-virtualenv
  pyright
  python
  black
  conda

  # terraform
  terraform
  terragrunt
  tflint
  tfsec
  tfswitch

  # databases
  postgresql
  mysql
  sqlite
  redis

  # version control
  gh
  git
  git-delta
  git-lfs
  git-secrets
  git-flow
  git-extras

  # scripting
  shellcheck
  bats
  bash-language-server
  zsh-syntax-highlighting
)

FONTS=(
  inter
  inter-tight
  hack
  jetbrains-mono
  fira-code
  fira-mono
  fira-sans
  fira-sans-condensed
  fira-sans-extra-condensed
)

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

# Update Homebrew
brew update

installed_packages=$(brew list --formula)

# Install or update brew packages
for package in "${BREW_PACKAGES[@]}"; do
  brew install $package
done

# install raycast
brew install --cask raycast

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install fonts from cask-fonts
brew tap homebrew/cask-fonts
for font in "${FONTS[@]}"; do
  brew install --cask font-$font
done

# install nerd fonts
brew tap homebrew/cask-fonts
fonts=$(brew search '/font-.*-nerd-font/' | awk '{ print $1 }')
# install only the fonts that are not installed
for font in $fonts; do
  echo "Installing $font"
  brew install --cask $font
done
