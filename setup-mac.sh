#!bash

# Symlinks: Target -> Destination
declare -A mappings=(
	["$(pwd)/lazygit/"]=$HOME/.config/lazygit
	["$(pwd)/nvim"]=$HOME/.config/nvim
)

# Dependencies
deps=(
	"fzf"
	"lazygit"
	"ripgrep"
	"screen"
	"starship"
	"tmux"
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

echo "Done!"
