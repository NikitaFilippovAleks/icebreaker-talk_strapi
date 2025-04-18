FROM node:22.14.0

WORKDIR /app

COPY . .

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y \
    jq \
    yarn \
    && yarn install --check-files --network-timeout=100000
