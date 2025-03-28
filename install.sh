#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

OS=$(uname)
    
# Function to add to path
add_to_path() {
    local DIR=$1
    if [[ ":$PATH:" != *":$DIR:"* ]]; then
        export PATH="$PATH:$DIR"
        if [[ "$OS" == "Darwin" ]]; then
            echo "export PATH=\$PATH:$DIR" >> ~/.zshrc
        else
            echo "export PATH=\$PATH:$DIR" >> ~/.bashrc
        fi
    else
        echo "$DIR is already in the PATH"
    fi
}


# Update and install git if not installed
if ! command_exists git; then
    echo "Updating package list and installing git..."
    sudo apt update && sudo apt install git -y
else
    echo "Git is already installed."
fi

# Install NVM (Node Version Manager)
if [ -z "$NVM_DIR" ]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc
else
    echo "NVM is already installed."
fi

# Install Node.js using NVM
if ! command_exists node; then
    echo "Installing Node.js..."
   # Source nvm directly
   export NVM_DIR="$HOME/.nvm"
   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install node
else
    echo "Node.js is already installed."
fi

# Install Rust
if ! command_exists cargo; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
    echo "Rust is already installed."
fi

# Install Neovim
if ! command_exists nvim; then
    echo "Installing Neovim..."
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
else
    echo "Neovim is already installed."
fi

# Clone the jack-IDE repository
if [ ! -d "$HOME/.config/nvim" ]; then
    echo "Cloning jack-IDE repository..."
    git clone https://github.com/messerli-wallace/jack-IDE.git $HOME/.config/nvim
else
    echo "jack-IDE repository is already cloned."
fi

# Clone the packer.nvim repository
if [ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
    echo "Cloning packer.nvim repository..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
else
    echo "packer.nvim repository is already cloned."
fi


if ! command_exists rg; then
    echo "Installing ripgrep..."
    cargo install ripgrep
    add_to_path '$HOME/.cargo/bin';
    echo "Path added"
else
    echo "ripgrep already installed."
fi

