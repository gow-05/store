# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.2.2
FROM ruby:${RUBY_VERSION}-slim

WORKDIR /app

# Install OS dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  curl \
  && rm -rf /var/lib/apt/lists/*

# Set env
ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT="development test"

# Install gems
COPY Gemfile Gemfile.lock ./

# Disable frozen mode explicitly (required after Gemfile changes)
RUN bundle config set frozen false \
 && bundle install


# Copy app
COPY . .

# Precompile assets
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
