set -e # exit on any error
# https://github.com/f1tenth/f1tenth_gym_ros?tab=readme-ov-file#launching-the-simulation
# to start the simulator
cd ~/sim_ws
. /opt/ros/foxy/setup.bash
. ~/sim_ws/install/local_setup.bash

ros2 launch f1tenth_gym_ros gym_bridge_launch.py &
