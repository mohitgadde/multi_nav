#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/mohit/catkin_turtle/src/turtlebot3/turtlebot3_teleop"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/mohit/catkin_turtle/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/mohit/catkin_turtle/install/lib/python2.7/dist-packages:/home/mohit/catkin_turtle/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/mohit/catkin_turtle/build" \
    "/usr/bin/python2" \
    "/home/mohit/catkin_turtle/src/turtlebot3/turtlebot3_teleop/setup.py" \
     \
    build --build-base "/home/mohit/catkin_turtle/build/turtlebot3/turtlebot3_teleop" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/mohit/catkin_turtle/install" --install-scripts="/home/mohit/catkin_turtle/install/bin"
