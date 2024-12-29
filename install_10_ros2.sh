# ROS2 Distributions : https://docs.ros.org/en/rolling/Releases.html

# https://docs.ros.org/en/foxy/Installation/Ubuntu-Install-Debians.html ubuntu 20.04
# https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html  ubuntu 22.04
# https://docs.ros.org/en/jazzy/Installation/Ubuntu-Install-Debs.html   ubuntu 24.04

# Check locale
locale

# Enable required repositories
time sudo apt install software-properties-common
time sudo add-apt-repository universe

# add the ROS 2 GPG key with apt
time sudo apt update
time sudo apt install curl -y
time sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
# add the repository to your sources list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install development tools (optional)
time sudo apt update
time sudo apt install ros-dev-tools

# Install ROS 2
time sudo apt update
time sudo apt upgrade

# Ubuntu 20.04
time sudo apt install ros-foxy-desktop python3-argcomplete

# initialize rosdep before later use
time sudo rosdep init
