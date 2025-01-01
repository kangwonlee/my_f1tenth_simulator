# ROS2 Distributions : https://docs.ros.org/en/rolling/Releases.html

# https://docs.ros.org/en/foxy/Installation/Ubuntu-Install-Debians.html ubuntu 20.04
# https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html  ubuntu 22.04
# https://docs.ros.org/en/jazzy/Installation/Ubuntu-Install-Debs.html   ubuntu 24.04

set -e

# Check locale
locale

# Enable required repositories
sudo apt install --yes software-properties-common
sudo add-apt-repository universe

# add the ROS 2 GPG key with apt
sudo apt update --yes
sudo apt install curl --yes
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
# add the repository to your sources list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install development tools (optional)
sudo apt update --yes
sudo apt install --yes ros-dev-tools

# Install ROS 2
sudo apt update --yes
sudo apt upgrade --yes

# Ubuntu 20.04
sudo apt install --yes ros-foxy-desktop python3-argcomplete

# initialize rosdep before later use
sudo rosdep init
