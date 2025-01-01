set -e

# https://github.com/f1tenth/f1tenth_gym_ros

cd ~/

sudo apt-get update --yes

# install pip package manager
sudo apt-get install --yes python3-pip
sudo snap install yq
rosdep update

# install simulator
mkdir -p ~/sim_ws/src
pushd ~/sim_ws # cwd ~/sim_ws
pushd src # cwd ~/sim_ws/src

if [ ! -d "f1tenth_gym_ros" ]; then
  git clone https://github.com/f1tenth/f1tenth_gym_ros
else
  pushd f1tenth_gym_ros # cwd ~/sim_ws/src/f1tenth_gym_ros
  git restore .
  git pull --rebase
  popd # cwd ~/sim_ws/src
fi

# install dependencies
if [ ! -d "f1tenth_gym_ros" ]; then
  git clone https://github.com/f1tenth/f1tenth_gym
  pushd f1tenth_gym # cwd ~/sim_ws/src/f1tenth_gym
else
  pushd f1tenth_gym # cwd ~/sim_ws/src/f1tenth_gym
  git pull --rebase
fi

pip3 install -e .
popd # cwd ~/sim_ws/src

# install more dependencies
# sudo apt-get install --yes ros-foxy-nav2-map-server ros-foxy-navigation2 ros-foxy-slam-toolbox ros-foxy-nav2-bringup ros-foxy-xacro ros-foxy-joint-state-publisher-gui ros-foxy-ackermann-msgs

# edit parameter for path to map file
export MAP_PATH=$(pwd)/f1tenth_gym_ros/maps/levine
yq eval --inplace '.bridge.ros__parameters.map_path = env(MAP_PATH)' f1tenth_gym_ros/config/sim.yaml

# run followings after edit
source /opt/ros/foxy/setup.bash
popd # cwd ~/sim_ws
rosdep install -i --from-path src --rosdistro foxy -r -y
colcon build
