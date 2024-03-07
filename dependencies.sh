#!/bin/bash

# Docker file dependency

git clone https://github.com/DerKleineMann/ursim_docker.git
sudo apt update
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
sudo usermod -aG docker $USER
su - $USER

cd ursim_docker/
docker build ursim/e-series -t myursim --build-arg VERSION=5.11.1.108318 --build-arg URSIM="https://s3-eu-west-1.amazonaws.com/ur-support-site/118926/URSim_Linux-5.11.1.108318.tar.gz"
cd ~
docker run --rm -it -p 5900:5900 -p 29999:29999 -p 30001-30004:30001-30004 myursim

# Python library dependency

sudo add-apt-repository ppa:sdurobotics/ur-rtde
sudo apt-get update
sudo apt install librtde librtde-dev

pip install --user ur_rtde
sudo apt-get install libboost-all-dev

git clone https://gitlab.com/sdurobotics/ur_rtde.git
cd ur_rtde
git submodule update --init --recursive
mkdir build
cd build
cmake ..
make
sudo make install