{ mkShellNoCC, ros, colcon }:

mkShellNoCC {
  packages = [
    #colcon
    #ros.ros2run
    #ros.turtlesim
    #ros.rqt
    #ros.rqt-gui
    #ros.rqt-common-plugins
    #ros.ros-environment
    #ros.ros2topic
    #ros.ros2node
    #ros.geometry-msgs
    #ros.rmw-fastrtps-dynamic-cpp
    #...
  ];

  RMW_IMPLEMENTATION = "rmw_fastrtps_dynamic_cpp";

  shellHook = ''
    echo "Welcome to the ROS playground!"
  '';
}
