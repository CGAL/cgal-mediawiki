ARG MW_VERSION=1.39

FROM mediawiki:${MW_VERSION}
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

COPY extensions/BacktickCode /var/www/html/extensions/BacktickCode

COPY install_cgalmediawiki_extension.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_cgalmediawiki_extension.sh
WORKDIR /var/www/html
RUN bash -x /usr/local/bin/install_cgalmediawiki_extension.sh

COPY scriptmediawiki.sh /usr/local/bin/

WORKDIR /var/www/html
COPY composer.json ./composer.json
COPY update-context/composer.json ./composer-update.json
RUN [ -z "${UPDATE}" ] || mv -f ./composer-update.json ./composer.json
RUN COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev

ENTRYPOINT ["/usr/local/bin/scriptmediawiki.sh"]
