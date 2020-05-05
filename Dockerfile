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

RUN set -x && \ 
    : Install CRF++ && \
    wget "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7QVR6VXJ5dWExSTQ" -O CRF++-0.58.tar.gz && \
    tar zxf CRF++-0.58.tar.gz && \
    cd CRF++-0.58 && \
    ./configure && make && make install && \
    echo "/usr/local/lib" >> /etc/ld.so.conf.d/lib.conf && \
    ldconfig

RUN set -x && \ 
    : Install CaboCha  && \
    : Obtain cabocha-0.69.tar.bz2. thanks to https://qiita.com/namakemono/items/c963e75e0af3f7eed732 && \
    curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7SDd1Q1dUQkZQaUU" > /dev/null && \
    CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)" && \ 
    curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=0B4y35FiV1wh7SDd1Q1dUQkZQaUU" -o cabocha-0.69.tar.bz2 && \
    tar jxf cabocha-0.69.tar.bz2 && \ 
    cd cabocha-0.69 && \
    ./configure --with-mecab-config=`which mecab-config` --with-charset=utf8 && \
    make && make install && ldconfig 

RUN chown jovyan:users -R /home/jovyan/work
USER jovyan
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
WORKDIR /home/jovyan/work/langproc-100fungo