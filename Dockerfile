FROM resin/rpi-raspbian:stretch

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    gcc \
    m4 \
    git \
    libopenblas-dev \
    libatlas-base-dev \
    libatlas-dev \
    libboost-all-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libhdf5-serial-dev \
    libleveldb-dev \
    liblmdb-dev \
    libopencv-dev \
    libprotobuf-dev \
    libsnappy-dev \
    protobuf-compiler \
    python3-dev \
    python3-numpy \
    python3-scipy \
    python3-pip \
    python3-setuptools \
    cython3 \
    vim \
    unzip \
    wget \
    zip \
    && \
    rm -rf /var/lib/apt/lists/*

ADD requirements.txt torch_raspi-0.4.0-cp35-cp35m-linux_armv7l.whl /tmp/

RUN pip3 install --upgrade pip
RUN pip3 install /tmp/torch_raspi-0.4.0-cp35-cp35m-linux_armv7l.whl
RUN pip3 install torchvision-raspi torchtext

# Install any needed packages specified in requirements.txt
RUN pip3 install --trusted-host pypi.python.org -r /tmp/requirements.txt

# Run app.py when the container launches

# dummy source code
RUN mkdir /app; echo "print(\"Howdy\")" > /app/app.py

# Make ports 80 or 4000 available to the world outside this container
# EXPOSE 80
EXPOSE 4000

# jupyterlab
EXPOSE 8888

WORKDIR /app

#CMD ["python3", "app.py"]

CMD ["/usr/local/bin/jupyter","lab","--ip=0.0.0.0","--port=8888","--allow-root","--no-browser"]

