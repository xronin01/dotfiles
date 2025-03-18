#!/usr/bin/env bash
LBIN="$HOME/.local/bin"

if ! command -v chdman >> /dev/null; then
echo "CHDMAN not found! Downloading and installing!"

echo "Downloading needed packages"
pkg install build-essential git cmake ninja -y
echo "Downloading source"
git clone https://github.com/CharlesThobe/chdman.git
cd ./chdman || exit
else
cd ./chdman || exit
git pull
fi
echo "Compiling"
mkdir build && cd build || exit
cmake -G Ninja .. && ninja
echo "Moving chdman to $LBIN and making it executable"
cp ./chdman "$LBIN"/chdman
chmod +x "$LBIN"/chdman
cd ../.. && rm -rf chdman/
