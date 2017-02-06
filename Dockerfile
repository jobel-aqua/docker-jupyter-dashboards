# -*- mode: ruby -*-
# vi: set ft=ruby :
FROM debian:8.7

MAINTAINER Aquabiota Solutions <devops@aquabiota.se>
# Anaconda3 MAINTAINER Kamil Kwiek <kamil.kwiek@continuum.io>
# https://hub.docker.com/r/continuumio/anaconda3/

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update --fix-missing && apt-get -y upgrade

RUN apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git
    # mercurial subversion

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-4.3.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

RUN echo 'conda upgrade anaconda' > /bin/bash && \
    echo 'pip install jupyter_dashboards --quiet' > /bin/bash && \
    echo 'jupyter dashboards quick-setup --sys-prefix' > /bin/bash && \
    echo 'jupyter nbextensions enable jupyter_dashboards --py --sys-prefix' > /bin/bash && \
    echo 'pip install jupyter_cms --quiet' > /bin/bash && \
    echo 'pip install jupyter_dashboards_bundlers' > /bin/bash && \
    echo 'conda install -y plotly' > /bin/bash && \
    echo 'pip install jupyter_declarativewidgets --quiet' > /bin/bash && \
    apt-get install -y build-essential checkinstall libssl-dev curl  && \
    mkdir /opt/notebooks && echo 'opt/notebooks volume available'

# Tini - A tiny but valid init for containers
# All Tini does is spawn a single child (Tini is meant to be run in a container),
# and wait for it to exit all the while reaping zombies and performing signal forwarding
# See: https://github.com/krallin/tini/
RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

ENV PATH /opt/conda/bin:$PATH

#VOLUME ["/opt/notebooks"]

#WORKDIR /opt/notebooks

#EXPOSE 8888

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
