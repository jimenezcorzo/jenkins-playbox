FROM httpd:latest
LABEL maintainer="rubenj@mx1.ibm.com"
COPY ./index.html /usr/local/apache2/htdocs/
