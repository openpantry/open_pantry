# Elixir 1.4: https://hub.docker.com/_/elixir/
FROM elixir:1.4.5
ENV DEBIAN_FRONTEND=noninteractive

# Install hex
RUN mix local.hex --force

# Install rebar
RUN mix local.rebar --force

# Install the Phoenix framework itself
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force

# Install NodeJS 6.x and the NPM
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y -q nodejs

# Install inotify for live reload
RUN apt-get install inotify-tools -y

# Set /app as workdir
RUN mkdir /app
ADD . /app
WORKDIR /app

# Install phoenix dependencies
RUN mix deps.get

# Install node dependecies
RUN cd assets/ && npm install -g yarn && yarn install && cd ..
