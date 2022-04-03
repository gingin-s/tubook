FROM ruby:2.6.5

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn 

WORKDIR /tubook

COPY Gemfile /tubook/Gemfile
COPY Gemfile.lock /tubook/Gemfile.lock
COPY package.json /tubook/package.json
COPY yarn.lock /tubook/yarn.lock

RUN gem install bundler 

RUN bundle config set --local path 'vendor/bundle' && \
    bundle install

COPY . /tubook