################################################################################
# Base image
################################################################################

FROM nginx:stable-alpine
VOLUME ["/var/www", "/etc/nginx/conf.d","/etc/letsencrypt"]
EXPOSE 80/tcp
EXPOSE 443/tcp

################################################################################
# Build instructions
################################################################################

# Remove default nginx configs.
# Install packages
RUN rm -f /etc/nginx/conf.d/* \
  && apk update && apk upgrade && apk add apache2-utils tzdata git vim net-tools busybox-extras iputils certbot certbot-nginx openssl tzdata bash

# Add configuration files
COPY conf/nginx.conf /etc/nginx/
COPY sites-available/ /etc/nginx/conf.d/
RUN ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime 
CMD ["nginx", "-g", "daemon off;"]