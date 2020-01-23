FROM ruby:2.6.5

# Instala nossas dependencias
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
  build-essential libpq-dev imagemagick curl gnupg

# Instalar NodeJS v8
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs

# Instalar o Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y yarn

ENV APP_PATH /onebitsanta
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH
COPY Gemfile ./
ENV BUNDLE_PATH /box
COPY . $APP_PATH

# Add a script to be executed every time the container starts.
COPY start.sh /usr/bin/
RUN chmod +x /usr/bin/start.sh
COPY start_jobs.sh /usr/bin/
RUN chmod +x /usr/bin/start_jobs.sh
ENTRYPOINT ["start.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]