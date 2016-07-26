FROM ruby:2.3.1-slim

MAINTAINER CreatekIO

RUN apt-get update && \
    apt-get install -y \
      git \
      build-essential \
      npm \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /slate

ENV TERM xterm

WORKDIR /slate
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 20 --retry 5

COPY . ./

CMD ["/bin/bash"]

