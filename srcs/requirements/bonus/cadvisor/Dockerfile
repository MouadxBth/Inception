FROM debian:bullseye

RUN apt update -y && \
    apt install -y wget && \
    wget https://github.com/google/cadvisor/releases/download/v0.47.2/cadvisor && \
    chmod +x cadvisor

CMD ["./cadvisor"]