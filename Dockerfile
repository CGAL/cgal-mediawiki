ARG MW_VERSION=1.45.1

FROM docker.io/library/mediawiki:${MW_VERSION}
ARG MW_VERSION
ENV MW_VERSION=${MW_VERSION}

ARG UPDATE=
ENV UPDATE=${UPDATE}
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    wget

RUN wget https://getcomposer.org/installer -O composer-setup.php \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm composer-setup.php

RUN set -x; eval $(bash -c 'BRANCH="REL${MW_VERSION/./_}"; BRANCH="${BRANCH%.*}"; echo "BRANCH=$BRANCH"'); \
  git clone --depth 1 https://gerrit.wikimedia.org/r/mediawiki/core.git --branch "$BRANCH" /tmp/mediawiki && \
  #diff -ru --exclude=.git --exclude=.github --exclude=.gitlab-ci.yml --exclude=languages --exclude=tests /var/www/html /tmp/mediawiki && \
  cd /tmp/mediawiki && git archive --format=tar HEAD | tar -x -C /var/www/html && \
  rm -rf /tmp/mediawiki

COPY extensions/BacktickCode /var/www/html/extensions/BacktickCode

COPY install_cgalmediawiki_extension.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_cgalmediawiki_extension.sh
WORKDIR /var/www/html
RUN bash -x /usr/local/bin/install_cgalmediawiki_extension.sh

COPY scriptmediawiki.sh /usr/local/bin/

WORKDIR /var/www/html
COPY composer.local.json ./composer.local.json
COPY update-context/composer.json ./composer-update.json
RUN [ -z "${UPDATE}" ] || mv -f ./composer-update.json ./composer.json
RUN COMPOSER_ALLOW_SUPERUSER=1 composer install --prefer-install=auto --verbose --no-dev

ENTRYPOINT ["/usr/local/bin/scriptmediawiki.sh"]
