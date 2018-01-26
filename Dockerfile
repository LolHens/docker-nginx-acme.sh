FROM nginx:latest
LABEL maintainer="LolHens <pierrekisters@gmail.com>"


ADD ["https://raw.githubusercontent.com/LolHens/docker-tools/master/bin/cleanimage", "/usr/local/bin/"]
RUN chmod +x "/usr/local/bin/cleanimage"

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y \
      python-certbot-nginx \
 && cleanimage
