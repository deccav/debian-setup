#!/bin/bash
# A script designed to make post-install setup easier for Debian based distributions.

echo "Choices: Chrome (1), Spotify (2), Gitkraken (3), Steam (4), VLC (5), GIMP (6)"
echo ""
echo "Please press the corresponding number for every program you'd like to install, then press enter."

echo ""
echo "Choices: "
read choices

echo ""
echo "Confirm that you would like to proceed (y/n): "
read docontinue
if [ $docontinue = "y" ];
then
elif [$docontinue = "n"];
then
	exit
fi

echo ""
echo "Would you like all installations to complete automatically? (y/n): "
read autocontinue

# Update sources
apt-get update

# Install Gdebi
apt-get -y install gdebi-core

# Download Google Chrome and install
if [[ $choices == *"1"* ]]; then
	cd /tmp &&
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
	if [$docontinue = "y"];
	then
	gdebi --non-interactive google-chrome-stable_current_amd64.deb
	elif [$docontinue = "n"];
	then
	gdebi google-chrome-stable_current_amd64.deb
fi

# Add Spotify keys, repository, then download and install
if [[ $choices == *"2"* ]]; then
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410 &&
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list &&
	apt-get update &&
	apt-get -y install spotify-client
fi

# Download and install Gitkraken
if [[ $choices == *"3"* ]]; then
	cd /tmp &&
	wget https://release.gitkraken.com/linux/gitkraken-amd64.deb &&
	if [$docontinue = "y"];
	then
	gdebi --non-interactive gitkraken-amd64.deb
	elif [$docontinue = "n"];
	then
	gdebi gitkraken-amd64.deb
fi

# Download and install Steam
if [[ $choices == *"4"* ]]; then
	cd /tmp &&
	wget http://media.steampowered.com/client/installer/steam.deb &&
	if [$docontinue = "y"];
	then
	gdebi --non-interactive steam.deb
	elif [$docontinue = "n"];
	then
	gdebi steam.deb
fi

# Download and install VLC
if [[ $choices == *"5"* ]]; then
	apt-get -y install vlc
fi

# Download and install GIMP
if [[ $choices == *"6"* ]]; then
	apt-get -y install gimp
fi
fi

echo ""
echo "Script complete - exiting"
exit
