FROM node:8-slim
RUN apt-get update \
  && apt-get install -y \
    make g++ pkg-config libglib2.0-dev \
    libexpat1-dev libjpeg-dev libtiff-dev \
    libpng-dev libgif-dev libwebp-dev graphicsmagick \
  && cd /tmp \
  && export LIBVIPS_VERSION=8.7.0-rc3 \
  && curl -L -O https://github.com/jcupitt/libvips/releases/download/v$LIBVIPS_VERSION/vips-$LIBVIPS_VERSION.tar.gz \
  && tar zxvf vips-$LIBVIPS_VERSION.tar.gz \
  && rm vips-$LIBVIPS_VERSION.tar.gz \
  && cd vips-* \
  && ./configure \
  && make \
  && make install \
  && apt-get remove -y make g++ pkg-config \
  && apt-get autoremove -y \
  && apt-get autoclean \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*