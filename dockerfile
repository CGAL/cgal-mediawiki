FROM mediawiki:1.39

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    wget

RUN wget https://getcomposer.org/installer -O composer-setup.php \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm composer-setup.php

COPY scriptmediawiki.sh /usr/local/bin/scriptmediawiki.sh
COPY composer.json /var/www/html/composer.json
COPY extensions/BacktickCode /var/www/html/extensions/BacktickCode
RUN chmod +x /usr/local/bin/scriptmediawiki.sh
RUN /usr/local/bin/scriptmediawiki.sh

CMD composer install && apache2-foreground