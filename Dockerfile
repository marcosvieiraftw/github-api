FROM ruby:2.5.1

ENV APP_DIR=/app

RUN apt-get update
RUN apt-get install -y nodejs

RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

# Cache bundle install
COPY Gemfile ./

COPY . $APP_DIR
RUN bundle install