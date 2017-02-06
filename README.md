# docker-jupyter-dashboards
Dockerfile to build an anaconda3 + jupyter_dashboards

# Docker Anaconda3
Created by refactoring the official [docker-anaconda3](https://hub.docker.com/r/continuumio/anaconda3/). 
Docker container with a bootstrapped installation of Anaconda (based on Python 3.6) that is ready to use. 

The Anaconda distribution is installed into the `/opt/conda` folder and ensures that the default user has the `conda` command in their path.

# Jupyter dasboards 
Includes:  
`jupyter_dasboards` v0.6.1
`jupyter_cms` v0.6.2
`jupyter_dashboards_bundlers` v0.8.1
`plotly` v1.12.9

# Usage
You can download and run this image using the following commands:

`docker pull aqbs/anaconda3-jupyter-dashboards` 

`docker run -i -t aqbs/anaconda3-jupyter-dashboards \ /bin/bash`

Alternatively, you can start a Jupyter Notebook server and interact with Anaconda via your browser:

    docker run -i -t -p 8888:8888 aqbs/anaconda3-jupyter-dashboards /bin/bash -c "/opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser"

You can then view the Jupyter Notebook by opening `http://localhost:8888` in your browser, or `http://<DOCKER-MACHINE-IP>:8888` if you are using a Docker Machine VM. 
