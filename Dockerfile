FROM nginx:latest
LABEL maintainer="LolHens <pierrekisters@gmail.com>"


ADD ["https://raw.githubusercontent.com/LolHens/docker-tools/master/bin/cleanimage", "/usr/local/bin/"]
RUN chmod +x "/usr/local/bin/cleanimage"

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y \
      apt-transport-https \
      ca-certificates \
      cron \
      curl \
      nano \
      procps \
 && cleanimage

ENV LE_WORKING_DIR=/acme.sh
ENV LE_CONFIG_HOME=/acmecerts
RUN curl "https://raw.githubusercontent.com/Neilpang/get.acme.sh/master/get.sh" | sh \
 && ln -s "~/.acme.sh/acme.sh" "/usr/local/bin/acme.sh" \
 && cleanimage

RUN curl -Lo "/usr/local/bin/my_init" "https://raw.githubusercontent.com/LolHens/docker-tools/master/bin/my_init" \
 && chmod +x "/usr/local/bin/my_init" \
 && mkdir "/etc/my_init.d"

RUN echo "/etc/init.d/cron start > /dev/null" > "/etc/my_init.d/cron" \
 && chmod +x "/etc/my_init.d/cron"

ENTRYPOINT ["my_init"]
CMD ["nginx", "-g", "daemon off;"]
