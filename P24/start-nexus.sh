#!/bin/bash
chmod +x "$0"
sudo apt-get update
sudo apt-get install expect -y
expect -c '
spawn sh -c "curl https://cli.nexus.xyz/ | sh"
expect "(Y/n)"
send "Y\r"
expect eof
'
source ~/.bashrc
cd ~/Downloads
wget https://raw.githubusercontent.com/maryluz90-temp2/temp1/main/nexus-network-linux-x86_64
chmod +x nexus-network-linux-x86_64
sudo mv nexus-network-linux-x86_64 /usr/local/bin/nexus-network
which nexus-network
sudo find / -type f -name nexus-network 2>/dev/null
if [ -f "/home/user/.nexus/bin/nexus-network" ]; then
    mv /home/user/.nexus/bin/nexus-network /home/user/.nexus/bin/nexus-network.bak
fi
hash -r
echo $PATH | tr ':' '\n'
export PATH=/usr/local/bin:$PATH
source ~/.bashrc
hash -r
nexus-network --version
git clone https://github.com/maryluz90-temp2/temp1.git && cp temp1/P24/* ~/.local/share/applications/ && rm -rf temp1
for file in 14094715 14094797 14124778 14149709 14185980 14185984; do
    path="$HOME/.local/share/applications/$file.desktop"
    if [ -f "$path" ]; then
        chmod +x "$path"
        gio set "$path" "metadata::trusted" true
        gtk-launch "$file"
    else
        echo "File $path not found, skipping."
    fi
done
sleep 10
rm -f ~/.local/share/applications/14094715.desktop
rm -f ~/.local/share/applications/14094797.desktop
rm -f ~/.local/share/applications/14124778.desktop
rm -f ~/.local/share/applications/14149709.desktop
rm -f ~/.local/share/applications/14185980.desktop
rm -f ~/.local/share/applications/14185984.desktop
