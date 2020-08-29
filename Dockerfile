FROM nginx:1.15
LABEL maintainer="Brian May <brian@linuxpenguins.xyz>"
COPY html/ /usr/share/nginx/html

ARG VCS_REF
ARG BUILD_DATE
ENV SHA=$VCS_REF
ENV REF=$BUILD_DATE

RUN sed -i 's,SHA,'"$VCS_REF"',' /usr/share/nginx/html/index.html
RUN sed -i 's,REF,'"$BUILD_DATE"',' /usr/share/nginx/html/index.html
