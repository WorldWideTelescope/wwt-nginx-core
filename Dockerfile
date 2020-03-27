# Copyright 2020 the .NET Foundation
# Licensed under the MIT License

FROM nginx:1.16-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY static /usr/share/nginx/html
