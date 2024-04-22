#! /bin/env bash
NVIM_CONF_REPO="https://github.com/ericmaustin/nvchad-custom.git"

NODE_PACKAGES=(
  yarn
  prettier
  typescript
  aws-cdk
)

GO_PACKAGES=(
  "golang.org/x/tools/cmd/godoc@latest"
)

# install node global packages
for package in "${NODE_PACKAGES[@]}"; do
  npm install -g $package
done

# install nvim config
if [ -d ~/.config/nvim ]; then
  echo "nvim config is already done"
  echo "To reinstall, delete ~/.config/nvim"
  exit 0
fi

git clone $NVIM_CONF_REPO ~/.config/nvim
# remove git history
rm -rf ~/.config/nvim/.git

# install go packages
for package in "${GO_PACKAGES[@]}"; do
  go install $package
done

# install nix
sh <(curl -L https://nixos.org/nix/install) --daemon
