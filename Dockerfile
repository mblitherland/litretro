FROM ruby:3.2
VOLUME /usr/local/bundle
WORKDIR /usr/src/app
RUN curl -sL https://dev.nodesource.com/setup_lts.x | bash - && \
    apt-get update && \
    apt-get install -y build-essential nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn
COPY . .
RUN (bundle check || bundle install) && bundle exec rails assets:precompile



