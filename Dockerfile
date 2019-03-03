FROM nginx:1.15
LABEL maintainer="Brian May <brian@linuxpenguins.xyz>"
COPY html/ /usr/share/nginx/html
