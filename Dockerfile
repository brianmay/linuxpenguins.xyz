FROM nginx:1.13
LABEL maintainer="Brian May <brian@linuxpenguins.xyz>"
COPY html/ /usr/share/nginx/html
