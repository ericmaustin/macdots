#! /bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DOTS_DIR=$SCRIPT_DIR/dots
DATESTAMP=$(date +%Y%m%d%H%M%S)

# Function to recursively copy files with backups
function copy_files_with_backups() {
  local source_dir=$1
  local destination_dir=$2

  # Loop through files in source directory
  for file in "$source_dir"/*; do
    if [ -f "$file" ]; then
      local filename=$(basename "$file")
      local destination_file="$destination_dir/$filename"

      # Check if destination file already exists
      if [ -f "$destination_file" ]; then
        # Create backup of existing file with timestamp
        local backup_file="$destination_file.$DATESTAMP.bak"
        mv "$destination_file" "$backup_file"
      fi

      # create dir if not exists
      mkdir -p "$destination_dir"

      # Copy file to destination directory
      cp "$file" "$destination_dir"
    fi
  done
}

# Usage example
copy_files_with_backups "$DOTS_DIR" "$HOME"

if [ ! -f "$HOME/.zprofile" ]; then
  touch $HOME/.zprofile
fi

if ! grep -q "eval \"(/opt/homebrew/bin/brew shellenv)\"" $HOME/.zprofile; then
  echo "Adding brew shellenv to zprofile"
  echo "eval \"(/opt/homebrew/bin/brew shellenv)\"" >> $HOME/.zprofile
fi

if ! grep -q "export PYENV_ROOT=\"$HOME/.pyenv\"" $HOME/.zprofile; then
  echo "Adding pyenv to zprofile"
  echo "export PYENV_ROOT=\"$HOME/.pyenv\"" >> $HOME/.zprofile
  echo "export PATH=\"$PYENV_ROOT/bin:$PATH\"" >> $HOME/.zprofile
  echo "eval \"$(pyenv init --path)\"" >> $HOME/.zprofile
fi

# Install ohmyzsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing ohmyzsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install powerlevel10k if not installed
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  echo "Installing powerlevel10k"
  git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Install zsh-autosuggestions, zsh-syntax-highlighting, fast-syntax-highlighting, zsh-autocomplete if not installed
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

if [ ! -d "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" ]; then
  echo "Installing fast-syntax-highlighting"
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autocomplete" ]; then
  echo "Installing zsh-autocomplete"
  git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
fi
