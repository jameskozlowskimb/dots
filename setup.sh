#!bash

# Symlinks: Target -> Destination
declare -A mappings=(
	["$(pwd)/.bash_profile"]=$HOME/.bash_profile
	["$(pwd)/.bashrc"]=$HOME/.bashrc
	["$(pwd)/.gitconfig"]=$HOME/.gitconfig
	["$(pwd)/tmux/.tmux.conf"]=$HOME/.tmux.conf
	["$(pwd)/alacritty"]=$HOME/.config/alacritty
	["$(pwd)/lazygit/"]=$HOME/.config/lazygit
	["$(pwd)/nvim"]=$HOME/.config/nvim
)

# Dependencies
deps=(
	"alacritty"
	"fzf"
	"git"
	"lazygit"
	"ripgrep"
	"screen"
	"starship"
	"tmux"
	"bat"
	"font-jetbrains-mono-nerd-font"
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
depString=""
for dep in "${deps[@]}"; do
	depString="$depString $dep"
done
brew install $depString

echo "Configuring tmux..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
$HOME/.tmux/plugins/tpm/bin/install_plugins
mkdir -p $HOME/.tmux/plugins/tmux/themes/
ln -sf $(pwd)/tmux/cyberdream.tmuxtheme $HOME/.tmux/plugins/tmux/themes/catppuccin_cyberdream.tmuxtheme

# install bat themes
mkdir -p $HOME/.config/bat/themes/
cp -f bat/themes/* $HOME/.config/bat/themes/
bat cache --clear
bat cache --build

echo "Done!"
