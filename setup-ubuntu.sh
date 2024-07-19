#!/bin/bash

# Symlinks: Target -> Destination
declare -A mappings=(
	["$(pwd)/lazygit/"]=$HOME/.config/lazygit
	["$(pwd)/nvim"]=$HOME/.config/nvim
)

# Dependencies
deps=(
	"fzf"
	"ripgrep"
	"screen"
	"tmux"
)

# Change to the directory of this script
cd "$(dirname "$0")"

echo "Removing existing files/directories..."
for key in "${!mappings[@]}"; do
	rm -rf ${mappings[$key]}
done

echo "Creating symbolic links..."
for key in "${!mappings[@]}"; do
	ln -sf $key ${mappings[$key]}
done

echo "Installing Dependencies..."
sudo apt update
depString=""
for dep in "${deps[@]}"; do
	depString="$depString $dep"
done
sudo apt install $depString

wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip \
&& cd ~/.local/share/fonts \
&& unzip JetBrainsMono.zip \
&& rm JetBrainsMono.zip \
&& fc-cache -fv

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo rm /bin/nvim
sudo ln -s /opt/nvim-linux64/bin/nvim /bin/nvim

echo "Done!"
