FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install -y openssl nginx &&\
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

## Generating a self-signed SSL certificate for secure HTTPS connections
#
# openssl req: Initiates a request to create an X.509 certificate.
#
# -x509: Specifies that a self-signed certificate should be generated.
# -nodes: Avoids encrypting the private key with a passphrase.
# -out /etc/nginx/ssl/inception.crt: Specifies the output file for the certificate.
# -keyout /etc/nginx/ssl/inception.key: Specifies the output file for the private key.
# -subj: Sets the certificate's subject fields such as country (C), state (ST), locality (L),
# organization (O), organizational unit (OU), common name (CN), and user ID (UID).
#
# These fields are used to identify the certificate.
RUN openssl req -x509 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=MA/ST=Casablanca/L=Settat/O=42/OU=42/CN=mbouthai.42.fr/UID=mbouthai"

COPY conf/default /etc/nginx/sites-enabled/default

EXPOSE 3306

## Running the Nginx web server in the foreground with the specified options.

# The -g option allows us to pass global directives to Nginx, and daemon off; keeps the process
# running in the foreground
CMD [ "nginx", "-g", "daemon off;"]