FROM debian:bookworm

# Run the following command to start qtcreator in the docker environment, assuming you are on a wayland system
# docker run -e XDG_RUNTIME_DIR=/tmp  -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY  -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY  -e QT_QPA_PLATFORM=wayland  imagename


WORKDIR /code

RUN apt update && apt install -y git meson cmake qt6-base-dev qt6-declarative-dev libfdisk-dev libudev-dev pkg-config qt6-wayland qtcreator
RUN apt install -y qml6-module-qtquick-controls qml6-module-qtquick-dialogs qml6-module-qtquick-window qml6-module-qtquick-dialogs qml6-module-qtquick-layouts qml6-module-qtqml-workerscript qml6-module-qtquick-templates qml6-module-qt-labs-folderlistmodel qml6-module-qtquick qml6-module-qtcore


CMD qtcreator
