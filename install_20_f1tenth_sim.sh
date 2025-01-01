# https://github.com/f1tenth/f1tenth_gym_ros

set -e

cd ~/

sudo apt update --yes
sudo apt install --yes ros-foxy-navigation2 ros-foxy-nav2-bringup ros-foxy-xacro ros-foxy-joint-state-publisher-gui ros-foxy-ackermann-msgs

# install pip package manager
sudo apt install --yes python3-pip
sudo snap install --yes yq
sudo rosdep init --yes
rosdep update --yes

# install dependencies
git clone https://github.com/f1tenth/f1tenth_gym
pushd f1tenth_gym # cwd ~/f1tenth_gym

pip3 install -e .
popd # cwd ~

# install simulator
mkdir -p ~/sim_ws/src
pushd ~/sim_ws # cwd ~/sim_ws
pushd src # cwd ~/sim_ws/src
git clone https://github.com/f1tenth/f1tenth_gym_ros

# edit parameter for path to map file
export MAP_PATH=$(pwd)/f1tenth_gym_ros/maps/levine
yq eval --inplace '.bridge.ros__parameters.map_path = env(MAP_PATH)' f1tenth_gym_ros/config/sim.yaml

# run followings after edit
source /opt/ros/foxy/setup.bash
popd # cwd ~/sim_ws
rosdep install -i --from-path src --rosdistro foxy -r --yes
colcon build
