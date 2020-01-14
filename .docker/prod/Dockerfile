# Stage: builder
FROM ruby:2.6.5 AS builder

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y \
    nodejs \
    yarn \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN gem install bundler -v 2.0.2

ENV APP_HOME /home/www/terraform_rails

WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/
RUN bundle install --without development test --jobs $(nproc) --retry 5 \
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete

COPY package.json yarn.lock $APP_HOME/
RUN yarn install --production --check-files


# Stage: final
FROM ruby:2.6.5

ARG RAILS_ENV

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y \
    nodejs \
    yarn \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV APP_USER app
ENV APP_USER_HOME /home/$APP_USER
ENV APP_HOME /home/www/terraform_rails

RUN useradd -m -d $APP_USER_HOME $APP_USER

WORKDIR $APP_HOME

RUN mkdir /var/www && \
    chown $APP_USER:$APP_USER /var/www && \
    chown -R $APP_USER:$APP_USER $APP_USER_HOME && \
    chown $APP_USER:$APP_USER $APP_HOME

USER $APP_USER

RUN mkdir -p tmp/pids

COPY --from=builder --chown=app:app /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder --chown=app:app $APP_HOME/node_modules/ $APP_HOME/node_modules/

COPY --chown=app:app . .

RUN bin/rails assets:precompile

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
