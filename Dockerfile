# Copyright 2020 the .NET Foundation
# Licensed under the MIT License

FROM nginx:1.16-alpine
COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY permanent_redirects.map /etc/nginx/permanent_redirects.map
COPY temporary_redirects.map /etc/nginx/temporary_redirects.map
COPY static /usr/share/nginx/html
RUN ["rm", "-f", "/etc/nginx/nginx.conf"]
CMD ["/bin/sh", "-c", "envsubst '$PUBLIC_FACING_DOMAIN_NAME' </etc/nginx/nginx.conf.template >/etc/nginx/nginx.conf && exec nginx -g 'daemon off;'"]
