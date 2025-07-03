FROM debian:bookworm-slim

ENV LANG=C.UTF-8

RUN apt-get update -y && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      # gnupg is required to install Node
      gnupg \
    ; \
    rm -rf /var/lib/apt/lists/*

ENV NODE_VERSION=22.17.0
ENV NODE_MAJOR=22
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    echo "Package: nodejs" | tee /etc/apt/preferences.d/nodejs > /dev/null && \
    echo "Pin: origin deb.nodesource.com" | tee -a /etc/apt/preferences.d/nodejs > /dev/null && \
    echo "Pin-Priority: 600" | tee -a /etc/apt/preferences.d/nodejs > /dev/null && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends nodejs=${NODE_VERSION}-1nodesource1 && \
    rm -rf /var/lib/apt/lists/* ; \
    corepack enable && \
    npm i -g npm && \
    # smoke tests
    node --version && npm --version && yarn --version

# Install google chrome
ENV GOOGLE_CHROME_VERSION=138.0.7204.49-1
RUN set -eux ; \
    apt-get update -y \
    && curl -Lo /tmp/google-chrome.deb "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${GOOGLE_CHROME_VERSION}_amd64.deb" \
    && apt install /tmp/google-chrome.deb -y --no-install-recommends \
    && rm /tmp/google-chrome.deb \
    && rm -rf /var/lib/apt/lists/*

ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV BROWSER_EXECUTABLE_PATH=/usr/bin/google-chrome
ENV PORT=9000

RUN set -eux ; \
  groupadd --gid 1000 node &&  \
  useradd --uid 1000 --gid node --shell /bin/bash --create-home node

ENV HOME=/home/node
ARG APP_HOME=/home/node/srv
WORKDIR $APP_HOME

RUN chown -R node:node $APP_HOME

USER node

# Uncomment when iterating locally to move faster:
#   COPY --chown=1000:1000 package.json ./
#   COPY --chown=1000:1000 package-lock.json ./
#   RUN npm install --omit=dev

COPY --chown=1000:1000 . ./

RUN npm install --omit=dev

EXPOSE $PORT
CMD ["node", "."]
