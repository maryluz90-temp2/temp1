#!/bin/bash

# Make this script executable (only needed the first time)
chmod +x "$0"

# Update and install expect
sudo apt-get update
sudo apt-get install expect -y

# Run nexus-cli installer with auto "Y"
expect -c '
spawn sh -c "curl https://cli.nexus.xyz/ | sh"
expect "(Y/n)"
send "Y\r"
expect eof
'

# Apply bashrc changes
source ~/.bashrc

# Download and install nexus-network binary
cd ~/Downloads
wget https://github.com/nexus-xyz/nexus-cli/releases/download/v0.9.7/nexus-network-linux-x86_64
chmod +x nexus-network-linux-x86_64
sudo mv nexus-network-linux-x86_64 /usr/local/bin/nexus-network

# Check installed path
which nexus-network
sudo find / -type f -name nexus-network 2>/dev/null

# Backup old binary if exists
if [ -f "/home/user/.nexus/bin/nexus-network" ]; then
    mv /home/user/.nexus/bin/nexus-network /home/user/.nexus/bin/nexus-network.bak
fi

# Refresh PATH
hash -r
echo $PATH | tr ':' '\n'
export PATH=/usr/local/bin:$PATH
source ~/.bashrc
hash -r

# Check nexus-network version
nexus-network --version

# Clone and move .desktop launcher files
git clone https://github.com/maryluz90-temp2/temp1.git && cp temp1/P1/* ~/.local/share/applications/ && rm -rf temp1
for file in 12898574 12898575 12927806 12927807 12928859 12928862; do
    path="$HOME/.local/share/applications/$file.desktop"
    if [ -f "$path" ]; then
        chmod +x "$path"
        gio set "$path" "metadata::trusted" true
        gtk-launch "$file"
    else
        echo "File $path not found, skipping."
    fi
done

# Wait 60 seconds, then delete specific files permanently
sleep 10
rm -f ~/.local/share/applications/12898574.desktop
rm -f ~/.local/share/applications/12898575.desktop
rm -f ~/.local/share/applications/12927806.desktop
rm -f ~/.local/share/applications/12927807.desktop
rm -f ~/.local/share/applications/12928859.desktop
rm -f ~/.local/share/applications/12928862.desktop


# Run datagram-cli in terminal
gnome-terminal -- bash -c "
    sudo wget https://github.com/Datagram-Group/datagram-cli-release/releases/latest/download/datagram-cli-x86_64-linux -O /usr/local/bin/datagram-cli &&
    sudo chmod +x /usr/local/bin/datagram-cli &&
    mkdir -p \"$HOME/tmp\" &&
    TMPDIR=\"$HOME/tmp\" datagram-cli run -- --key b4c130373bf0dc471b284c8555439b83;
    exec bash"
