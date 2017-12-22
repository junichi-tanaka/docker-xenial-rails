FROM ubuntu:xenial

ENV APPDIR /rails
ENV NODE_VERSION node-v6.12.2

WORKDIR $APPDIR

RUN apt-get update \
    && apt-get install -y \
          build-essential \
          software-properties-common \
          tzdata \
          libxml2 \
          zlib1g-dev \
          libsqlite3-dev \
          libmysqlclient-dev \
          curl \
          apt-transport-https
RUN apt-add-repository ppa:brightbox/ruby-ng \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ruby2.4 ruby2.4-dev \
    && gem install bundler
RUN curl https://nodejs.org/dist/latest-v6.x/$NODE_VERSION-linux-x64.tar.xz | tar -C /usr/local -Jxf - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn \
    && rm -rf /var/lib/apt/lists/*

ENV PATH $PATH:/usr/local/$NODE_VERSION-linux-x64/bin

VOLUME $APPDIR
EXPOSE 3000

ENV TZ Asia/Tokyo

CMD ["ruby"]
