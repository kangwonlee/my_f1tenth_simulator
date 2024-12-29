# https://github.com/f1tenth/f1tenth_gym_ros
cd ~/

time sudo apt update
time sudo apt install ros-foxy-navigation2
time sudo apt install ros-foxy-nav2-bringup
time sudo apt install ros-foxy-xacro
time sudo apt install ros-foxy-joint-state-publisher-gui
time sudo apt install ros-foxy-ackermann-msgs

# install pip package manager
time sudo apt install python3-pip
time sudo snap install yq
time sudo rosdep init
time rosdep update

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
time yq eval --inplace '.bridge.ros__parameters.map_path = env(MAP_PATH)' f1tenth_gym_ros/config/sim.yaml

# run followings after edit
source /opt/ros/foxy/setup.bash
popd # cwd ~/sim_ws
rosdep install -i --from-path src --rosdistro foxy -r -y
colcon build
