FROM jupyter/datascience-notebook:latest

# install some
USER root

# 日本語フォント
RUN apt-get update && apt-get install -y fonts-noto-cjk
#RUN apt-get install -y ttf-kochi-gothic xfonts-intl-japanese xfonts-intl-japanese-big xfonts-kaname

# install mecab
RUN git clone https://github.com/taku910/mecab.git \
  && cd mecab/mecab \
  && ./configure  --enable-utf8-only \
  && make \
  && make check \
  && make install \
  && ldconfig \
  && cd ../mecab-ipadic \
  && ./configure --with-charset=utf8 \
  && make \
  && make install

RUN chown jovyan:users -R /home/jovyan/work
USER jovyan
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
WORKDIR /home/jovyan/work/langproc-100fungo