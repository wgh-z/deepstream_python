FROM nvcr.io/nvidia/deepstream:7.0-samples-multiarch

COPY . /opt/nvidia/deepstream/deepstream-7.0/sources/

RUN chmod +x /opt/nvidia/deepstream/deepstream-7.0/sources/deepstream_python_binding.sh

RUN /opt/nvidia/deepstream/deepstream-7.0/sources/deepstream_python_binding.sh

WORKDIR /opt/nvidia/deepstream/deepstream-7.0/sources/deepstream_python_apps

# docker run --gpus all -it --rm --net=host --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -w /opt/nvidia/deepstream/deepstream-7.0 --name deepstream7.0 nvcr.io/nvidia/deepstream:7.0-samples-multiarch
