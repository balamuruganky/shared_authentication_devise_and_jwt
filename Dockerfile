FROM ruby:2.6.3-alpine AS builder
ENV BUNDLER_VERSION=2.1.4
RUN apk add \
    build-base \
    postgresql-dev \
    git
COPY Gemfile* .
RUN gem install bundler -v $BUNDLER_VERSION
RUN gem update --system 2.6.3
#RUN bundle config set deployment true
RUN bundle config set force_ruby_platform true
RUN bundle install
RUN bundle update --bundler

FROM ruby:2.6.3-alpine AS runner
RUN apk update && apk upgrade --no-cache
RUN apk add \
    tzdata \
    postgresql-dev \
    npm \
    git \
    nodejs-current \
    make \
    python \
    g++ \
    bash
RUN npm install -g yarn
WORKDIR /shared_devise_jwt
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /usr/local/lib/ /usr/local/lib/
COPY . .
RUN yarn install --check-files
RUN bundle exec rake assets:precompile
RUN yarn add bootstrap

# Add a script to be executed every time the container starts.
COPY ./entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
