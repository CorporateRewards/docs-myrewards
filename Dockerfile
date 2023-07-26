FROM ruby:3.0-slim

WORKDIR /srv/slate

EXPOSE 4567

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        nodejs \
        openssh-client \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

COPY . /srv/slate

RUN chmod +x /srv/slate/slate.sh

ENTRYPOINT ["/srv/slate/slate.sh"]
CMD ["build"]
