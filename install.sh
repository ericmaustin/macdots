#! /bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Installing dot files and ohmyzsh"
source $SCRIPT_DIR/install_dots.sh

echo "Installing homebrew and homebrew apps"
source $SCRIPT_DIR/brew.sh

echo "Installing dev tools, languages, and editors"
source $SCRIPT_DIR/install_dev.sh
