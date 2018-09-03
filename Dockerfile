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
 && echo "cron" > "/etc/my_init.d/cron"
 && curl "https://raw.githubusercontent.com/Neilpang/get.acme.sh/master/get.sh" | sh \
 && cleanimage

RUN curl -Lo "/usr/local/bin/my_init" "https://raw.githubusercontent.com/LolHens/docker-tools/master/bin/my_init" \
 && chmod +x "/usr/local/bin/my_init" \
 && mkdir "/etc/my_init.d"


ENTRYPOINT ["my_init"]
