FROM httpd:2.4
LABEL maintainer="rubenj@mx1.ibm.com"
COPY ./index.html /usr/local/apache2/htdocs/
