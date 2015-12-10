# Pull base image.
FROM cthulhu666/docker-rbenv
MAINTAINER Marek Fajkus <marek.faj@gmail.com>

# As the user Ruby
USER ruby
RUN cd /home/ruby/.rbenv/plugins/ruby-build && git pull

# Install ruby 2.2.2
RUN \
   rbenv install 2.2.2 \
&& rbenv global 2.2.2

CMD ["true"]

# install Bundler
RUN gem install bundler
RUN chown ruby:ruby -R /home/ruby/.rbenv

# As the user Ruby
USER root

# Add Gemfile and Gemfile.lock
ADD Gemfile /ruby/picture-server/Gemfile
ADD Gemfile.lock /ruby/picture-server/Gemfile.lock
RUN chown -R ruby:ruby /ruby/picture-server
RUN \
    mkdir /.bundle \
&&  chown -R ruby:ruby /.bundle

# User ruby
USER ruby

# Bundle to install
WORKDIR /ruby/picture-server
RUN bundle install --without development test

# Add our project to image
ADD ./ /ruby/picture-server

