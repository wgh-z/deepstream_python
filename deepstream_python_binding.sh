#!/bin/bash

# chmod +x deepstream_python_binding.sh

function preinstall () {
    echo "正在安装依赖包..."
    sed -i 's/archive.ubuntu.com/mirrors.cloud.tencent.com/g' /etc/apt/sources.list
    sed -i 's/security.ubuntu.com/mirrors.cloud.tencent.com/g' /etc/apt/sources.list

    apt update

    apt-get install -y python3-gi python3-dev python3-gst-1.0 python-gi-dev git meson \
    python3 python3-pip python3.10-dev cmake g++ build-essential libglib2.0-dev \
    libglib2.0-dev-bin libgstreamer1.0-dev libtool m4 autoconf automake \
    libgirepository1.0-dev libcairo2-dev

    apt-get install -y libgstreamer-plugins-base1.0-dev

    apt-get install -y apt-transport-https ca-certificates
    update-ca-certificates
    echo "依赖包安装完成"
}

function clone_deepstream_python () {
    cd /opt/nvidia/deepstream/deepstream-7.0/sources/
    git config --global http.version HTTP/1.1
    git clone https://github.com/NVIDIA-AI-IOT/deepstream_python_apps.git
}

function clone_3rdparty () {
    cd /opt/nvidia/deepstream/deepstream-7.0/sources/deepstream_python_apps/3rdparty/

    git config --global http.version HTTP/2

    git clone https://gitclone.com/github.com/GStreamer/gstreamer.git
    cd gstreamer
    git checkout 1.20.3
    cd ../

    git clone https://gitclone.com/github.com/pybind/pybind11.git
    cd pybing11
    git checkout v2.5.0
    cd ../
}
 
function install_gst_python () {
    cd gstreamer/subprojects/gst-python/
    meson setup build
    cd build
    ninja
    ninja install
}

function install_pybind11 () {
    cd /opt/nvidia/deepstream/deepstream-7.0/sources/deepstream_python_apps/bindings
    mkdir build
    cd build
    cmake ..
    make -j$(nproc)
}

function get_wheel () {
    wget https://github.com/NVIDIA-AI-IOT/deepstream_python_apps/releases/download/v1.1.11/pyds-1.1.11-py3-none-linux_x86_64.whl
}

function install_pyds () {
    pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/
    python3 -m pip install --upgrade pip
    pip3 install ./pyds-1.1.11-py3-none*.whl
    pip3 install cuda-python
}

function main () {
    preinstall
    clone_deepstream_python

    # install from user build binging
    # clone_3rdparty
    # install_gst_python
    # install_pybind11

    # install from wheel file
    # get_wheel

    install_pyds
}

main
