FROM ruby:2.6.0
MAINTAINER btenggren20@gmail.com

# Install APT deps to run rails and ruby gems.
RUN apt-get update && apt-get install -y \
      build-essential \
      locales \
      nodejs

# Use en_US.UTF-8 as our locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Define the working directory. This is where all further RUN, COPY, and ENTRYPOINT
# commands will run from
RUN mkdir -p app/
WORKDIR /app

# Add our gemfile
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy in our app
COPY . ./

# Set the external Port
EXPOSE 3000

# Prepend bundle exec to all commands run
ENTRYPOINT ["bundle", "exec"]

# Finally the run command for when we start
CMD ["rails", "server", "-b", "0.0.0.0"]
