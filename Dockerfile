# SEE: https://docs.docker.com/compose/rails/

FROM ruby:2.6.0
MAINTAINER btenggren20@gmail.com

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir /rails_test
WORKDIR /rails_test
COPY Gemfile /rails_test/Gemfile
COPY Gemfile.lock /rails_test/Gemfile.lock
RUN bundle install
COPY . /rails_test

# Add a script to be executed every time the container starts.
COPY bin/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
