# https://github.com/uselauncher/static
# https://hub.docker.com/r/uselauncher/static
FROM debian:buster-slim

RUN set -ex \
  && apt-get update \
  && apt-get install -y --no-install-recommends autoconf dpkg-dev file g++ gcc libc-dev make pkg-config re2c ca-certificates curl xz-utils

RUN set -ex \
  && apt-get update \
  && apt-get install -y git libonig-dev libzip-dev zip unzip lsb-release wget gnupg nano vim procps dirmngr

# Install Node.js version management
RUN set -ex \
  && curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n \
  && bash n 16 \
  && npm install -g n yarn \
  \
  # Clear cache
  && apt-get clean && rm -rf /var/lib/apt/lists/* \
  \
  # Add user to run the laravel application
  && groupadd -g 1000 launcher \
  && useradd -u 1000 -ms /bin/bash -g launcher launcher

WORKDIR /app
USER launcher
CMD ["npm"]