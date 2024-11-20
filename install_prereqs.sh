#! /usr/bin/bash

sudo apt update

# Define the packages to be checked and installed
packages="python3-pip python3-dev cmake unzip"

# Loop through each package to check and install if necessary
for pkg in $packages; do
    if ! dpkg -s $pkg >/dev/null 2>&1; then
        echo "$pkg is not installed. Installing..."
        sudo apt install -y $pkg
    else
        echo "$pkg is already installed."
    fi
done

# Separately handle Jupyter Notebook installation as it's a Python package
if ! command -v jupyter >/dev/null 2>&1; then
    echo "Jupyter Notebook is not installed. Installing..."
    sudo -H pip3 install notebook
else
    echo "Jupyter Notebook is already installed."
fi

sudo -H pip3 install jupyterlab

# Path to the .bashrc file
bashrc_path="$HOME/.bashrc"

# Add local bin to path
echo "Adding local bin to PATH..."
line_to_add='export PATH="$HOME/.local/bin:${PATH}"'

# Check if local bin already exists in the .bashrc file
if ! grep -Fxq "$line_to_add" "$bashrc_path"; then
    # If the line doesn't exist, append it to the .bashrc file
    echo "$line_to_add" >> "$bashrc_path"
    echo "Added PATH line to $bashrc_path"
else
    echo "PATH line already exists in $bashrc_path"
fi

# Source the .bashrc to apply changes immediately
source "$bashrc_path"

# install sciunit from the given executable
echo "Installing sciunit from executable... this could take several minutes"
cd ~/Flinc
pip3 install sciunit2-0.4.post117.dev203853284.tar.gz