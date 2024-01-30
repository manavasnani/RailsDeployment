# Use an official Ruby runtime as a parent image
FROM ruby:2.7.4

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Ruby dependencies
RUN bundle install

# Copy the main application into the container
COPY . .

# Install nodejs and yarn for asset compilation
RUN apt-get update && \
    apt-get install -y nodejs yarn && \
    rm -rf /var/lib/apt/lists/*

# Set the environment variable for Rails to production
ENV RAILS_ENV=production

# Precompile assets
# RUN bundle exec rake assets:precompile

# Run database migrations
RUN bundle exec rake db:migrate

# Copy credentials file into the container
COPY config/master.key config/

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the application
CMD ["rails", "server", "-b", "0.0.0.0"]












