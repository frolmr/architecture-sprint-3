FROM ruby:3.3.5

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /telemetry_service

ADD telemetry_service/Gemfile* ./
RUN bundle install
ADD telemetry_service/ .

EXPOSE 8000
