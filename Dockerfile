FROM matrixdotorg/synapse:v1.49.2

COPY start.sh /start.sh
RUN chmod +x /start.sh
RUN apt-get update
RUN apt-get install -y iputils-ping inotify-tools

WORKDIR /
COPY watch_hosts.sh /watch_hosts.sh

ENTRYPOINT [ "/start.sh" ]