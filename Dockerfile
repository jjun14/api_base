FROM ubuntu:14.04
FROM ruby:2.3
MAINTAINER jimmy.s.jun@gmail.com

# install system dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

RUN mkdir -p /app
WORKDIR /app

# copy these to install ruby gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

# copy main app to container
COPY . ./

# expose docker host on port 3000
EXPOSE 3000

# Configure an entry point, so we don't need to specify 
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["rails", "server", "-b", "0.0.0.0"]
