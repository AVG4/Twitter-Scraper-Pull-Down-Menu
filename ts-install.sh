#!/bin/bash

# Installation Script for Twitter Scraper Tool 

echo "\e[31mInstalling Pip...\e[0m"

apt-get install python3-pip -y

echo "\e[31mInstalling lolcat...\e[0m"

pip3 install lolcat

echo "\e[31mCloning twint git repository...\e[0m"

git clone https://github.com/twintproject/twint.git
cd twint

echo "\e[31mInstalling requirements...\e[0m"

pip3 install -r requirements.txt

echo -e "\e[31mSetting up twint...\e[0m"

python3 setup.py install

echo "\e[31mGit Cloning Twitter Scraper Tool...\e[0m"

git clone https://github.com/AVG4/Twitter-Scraper-Tool/blob/main/twitterscrape.sh

bash twitterscrape.sh
