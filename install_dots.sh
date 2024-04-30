#! /bin/env bash
shopt -s dotglob
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DOTS_DIR="$SCRIPT_DIR/dots"
DATESTAMP=$(date +%Y%m%d%H%M%S)

echo "dots dir: $DOTS_DIR"

# Loop through files in source directory
for file in "$DOTS_DIR"/*; do
  echo "Processing $file"
  if [ ! -f "$file" ]; then
    break;
  fi

  filename=$(basename "$file")
  destination_file="$HOME/$filename"
  destination_dir=$(dirname "$destination_file")

  # Create destination directory if it doesn't exist
  mkdir -p "$destination_dir"

  echo "Destination file: $destination_file"

  # Check if destination file already exists
  if [ -f "$destination_file" ]; then
    # Create backup of existing file with timestamp
    echo "Creating backup of $destination_file"
    backup_file="$destination_file.$DATESTAMP.bak"
    mv "$destination_file" "$backup_file"
  fi

  # Copy file to destination directory
  echo "Copying $file to $destination_file"
  cp "$file" "$destination_file"
done

if [ ! -f "$HOME/.zprofile" ]; then
  touch $HOME/.zprofile
fi

if ! grep -q "eval \"(/opt/homebrew/bin/brew shellenv)\"" $HOME/.zprofile; then
  echo "Adding brew shellenv to zprofile"
  echo -e "\neval \"(/opt/homebrew/bin/brew shellenv)\"\n" >> $HOME/.zprofile
fi

if ! grep -q "export PYENV_ROOT=\"$HOME/.pyenv\"" $HOME/.zprofile; then
  echo "Adding pyenv to zprofile"
  echo -e "\nexport PYENV_ROOT=\"$HOME/.pyenv\"" >> $HOME/.zprofile
  echo -e "\nexport PATH=\"$PYENV_ROOT/bin:$PATH\"" >> $HOME/.zprofile
  echo -e "eval \"\$(pyenv init --path)\"" >> $HOME/.zprofile
fi

OMZ_HOME="$HOME/.oh-my-zsh"
OMZ_CUSTOM="$OMZ_HOME/custom"

# Install ohmyzsh if not installed
if [ ! -d "$OMZ_HOME" ]; then
  echo "Installing ohmyzsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


# Install powerlevel10k if not installed
if [ ! -d "${OMZ_CUSTOM}/themes/powerlevel10k" ]; then
  echo "Installing powerlevel10k"
  git clone --depth 1 https://github.com/romkatv/powerlevel10k.git "${OMZ_CUSTOM}/themes/powerlevel10k"
fi

# Install zsh-autosuggestions, zsh-syntax-highlighting, fast-syntax-highlighting, zsh-autocomplete if not installed
if [ ! -d "${OMZ_CUSTOM}/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "${OMZ_CUSTOM}/plugins/zsh-autosuggestions"
fi

if [ ! -d "${OMZ_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${OMZ_CUSTOM}/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "${OMZ_CUSTOM}/plugins/fast-syntax-highlighting" ]; then
  echo "Installing fast-syntax-highlighting"
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "${OMZ_CUSTOM}/plugins/fast-syntax-highlighting"
fi

if [ ! -d "${OMZ_CUSTOM}/plugins/zsh-autocomplete" ]; then
  echo "Installing zsh-autocomplete"
  git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "${OMZ_CUSTOM}/plugins/zsh-autocomplete"
fi
 
