FROM ruby:2.7.0-slim

COPY . $HOME/app
WORKDIR $HOME/app
RUN bundle config set without 'development test' \
    && bundle install --quiet

CMD [ "ruby", "app.rb" ]
