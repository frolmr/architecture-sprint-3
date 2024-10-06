FROM ruby:3.3.5

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /device_management

ADD device_management/Gemfile* ./
RUN bundle install
ADD device_management/ .

EXPOSE 8000
