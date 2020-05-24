FROM nginx:1.15
LABEL maintainer="Brian May <brian@linuxpenguins.xyz>"
COPY html/ /usr/share/nginx/html

ARG GITHUB_SHA
ARG GITHUB_REF
ENV SHA=$GITHUB_SHA
ENV REF=$GITHUB_REF

RUN sed -i 's,SHA,'"$GITHUB_SHA"',' /usr/share/nginx/html/index.html
RUN sed -i 's,REF,'"$GITHUB_REF"',' /usr/share/nginx/html/index.html
