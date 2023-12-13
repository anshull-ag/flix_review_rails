
# Use an official Ruby runtime as a parent image
FROM ruby:3.2.2


# Set the working directory in the container
WORKDIR /usr/src/app


# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client


# Install Rails and Bundler
RUN gem install rails bundler


# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./


# Install Rails application dependencies
RUN bundle install


# Copy the rest of the application code into the container
COPY . .

# Run database migrations and seed data
RUN rails db:migrate && rails db:seed


# Expose port 3000 to the outside world
EXPOSE 3000


# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
