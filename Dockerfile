FROM jupyter/datascience-notebook:latest

RUN chown jovyan:users -R /home/jovyan/work
USER jovyan
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
WORKDIR /home/jovyan/work/langproc-100fungo