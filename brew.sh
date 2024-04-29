#! /bin/env bash

# Install or update all homebrew packages

PACKAGES=(
  # security
  openssl
  gpg

  # mac improvements
  alt-tab

  # editors
  neovim
  tmux

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
  tre
  screen
  pinentry-mac
  bat
  nnn
  zoxide
  thefuck
  tldr
  scc
  aria2
  entr
  just
  sd
  xsel
  gnu-sed

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
  coreutils
  moreutils

  # rust
  rust
  rustup
  rust-analyzer

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
  miniconda

  # haskell
  ghc
  haskell-stack
  haskell-lanugage-server
  stylish-haskell

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

  # misc
  utm
  imagemagick
  xcodegen

  # gui apps
  warp
  raycast
  zoom
  slack
  signal
  discord
  spotify
  firefox
  google-chrome
)

# Fonts from cask-fonts
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

# Install or update brew packages
for package in "${PACKAGES[@]}"; do
  brew install $package
done

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
