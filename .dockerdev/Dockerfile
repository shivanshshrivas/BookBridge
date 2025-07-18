ARG RUBY_VERSION=3.3.5
ARG PG_MAJOR=16
ARG NODE_MAJOR=22
ARG YARN_VERSION=1.22.22
ARG DISTRO_NAME=bullseye

# Here we add the the name of the stage ("base")
FROM ruby:$RUBY_VERSION-slim-$DISTRO_NAME AS base

# A recommended memory optimization for Ruby apps https://devcenter.heroku.com/articles/tuning-glibc-memory-behavior
ENV MALLOC_ARENA_MAX=2

# Install application dependencies and then clean up after ourselves
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    curl \
    gnupg2 \
    less \
    tzdata \
    time \
    locales \
    shared-mime-info \
    libjemalloc2 \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log \
  && update-locale LANG=C.UTF-8 LC_ALL=C.UTF-8

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2 \
  MALLOC_CONF="dirty_decay_ms:1000,narenas:2,background_thread:true"

ARG DISTRO_NAME
ARG PG_MAJOR
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
    gpg --dearmor -o /usr/share/keyrings/postgres-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/postgres-archive-keyring.gpg] https://apt.postgresql.org/pub/repos/apt/" \
    $DISTRO_NAME-pgdg main $PG_MAJOR | tee /etc/apt/sources.list.d/postgres.list > /dev/null
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    libpq-dev \
    postgresql-client-$PG_MAJOR \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

WORKDIR /app

EXPOSE 3000
CMD ["/usr/bin/bash"]

FROM base as builder

# Install tools that are necessary for building but are not necessary in the built image
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    git \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log


ARG NODE_MAJOR
ARG YARN_VERSION
# Install NodeJS and Yarn
RUN mkdir -p /etc/apt/keyrings \ 
  && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
  && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    nodejs \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && truncate -s 0 /var/log/*log
RUN npm install -g yarn@$YARN_VERSION





# Then, we define the "development" stage from the builder one
FROM builder AS development

# The major difference from the base image is that we may have development-only system
# dependencies (like Vim or graphviz).
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    git \
    vim \
    nano \
    sudo \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

# Create a non-root user which matches the UID of the host machine
# in order to have file permissions work out of the box.
# Make that user a sudoer so you can still do root operations in the container if necessary.
ARG UID
RUN useradd --uid ${UID} --shell /bin/bash --create-home bnb \
  && echo 'bnb ALL=(ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo
USER bnb
# The mounted volume will be owned by root unless we pre-create the folder here. The base ruby image automatically
# handles the /usr/local/bundle folder we just need to handle other volumes that we create.
RUN sudo mkdir /app/node_modules \
  && sudo chown -R bnb:bnb /app/node_modules \
  && sudo mkdir -p /app/tmp/cache \
  && sudo chown -R bnb:bnb /app/tmp/cache



# The production-builder image is responsible for installing dependencies and compiling assets
FROM builder as production-builder

# First, we create and configure a dedicated user to run our application
# DUP: user setup
RUN groupadd --gid 1005 bnb \
  && useradd --uid 1005 --gid bnb --shell /bin/bash --create-home bnb
USER bnb
RUN mkdir /home/bnb/app
WORKDIR /home/bnb/app

# Then, we re-configure Bundler
ARG RAILS_ENV=production
ENV RAILS_ENV=$RAILS_ENV \
  LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3 \
  BUNDLE_APP_CONFIG=/home/bnb/bundle \
  BUNDLE_PATH=/home/bnb/bundle \
  GEM_HOME=/home/bnb/bundle

# We purposefully copy limited files (i.e. Gemfile, yarn.lock) at first
# in order to re-use the Docker build cache as much as possible. Docker
# cache's each layer of your build and will re-use it if nothing has
# changed. By only copying the relevant files, we get a pretty good
# chance of reusing that layer. Whereas if we copied everything in we
# would almost definitely not be able to use the cache because something
# probably changed in your deploy.

# Install Ruby gems
COPY --chown=bnb:bnb Gemfile Gemfile.lock ./
RUN mkdir $BUNDLE_PATH \
  && bundle config --local deployment 'true' \
  && bundle config --local path "${BUNDLE_PATH}" \
  && bundle config --local without 'development test' \
  && bundle config --local clean 'true' \
  && bundle config --local no-cache 'true' \
  && bundle install --jobs=${BUNDLE_JOBS} \
  && rm -rf $BUNDLE_PATH/ruby/3.1.0/cache/* \
  && rm -rf /home/bnb/.bundle/cache/*

# Install JS packages
COPY --chown=bnb:bnb package.json yarn.lock ./
RUN yarn install --check-files

# Copy code
COPY --chown=bnb:bnb . .

# Precompile assets
# NOTE: The command may require adding some environment variables (e.g., SECRET_KEY_BASE) if you're not using
# credentials.
ARG RAILS_MASTER_KEY
RUN RAILS_MASTER_KEY=$RAILS_MASTER_KEY bundle exec rails assets:precompile





# Finally, our production image definition
FROM base AS production

# Create and configure a dedicated user (use the same name as for the production-builder image)
# DUP: user setup
RUN groupadd --gid 1005 bnb \
  && useradd --uid 1005 --gid bnb --shell /bin/bash --create-home bnb
RUN mkdir /home/bnb/app
WORKDIR /home/bnb/app
USER bnb

# Ruby/Rails env configuration
ARG RAILS_ENV=production
ENV RAILS_ENV=$RAILS_ENV \
  BUNDLE_APP_CONFIG=/home/bnb/bundle \
  BUNDLE_PATH=/home/bnb/bundle \
  GEM_HOME=/home/bnb/bundle \
  PATH="/home/bnb/app/bin:${PATH}" \
  LANG=C.UTF-8 \
  LC_ALL=C.UTF-8

# Copy code
COPY --chown=bnb:bnb . .

# Copy artifacts
# 1) Installed gems
COPY --from=production-builder $BUNDLE_PATH $BUNDLE_PATH
# 2) Compiled assets
COPY --from=production-builder /home/bnb/app/public/assets /home/bnb/app/public/assets
# 3) We can even copy the Bootsnap cache to speed up our Rails server load!
COPY --chown=bnb:bnb --from=production-builder /home/bnb/app/tmp/cache/bootsnap* /home/bnb/app/tmp/cache/

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]