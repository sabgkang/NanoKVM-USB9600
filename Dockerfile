FROM nginx:1.29.1-alpine

RUN apk add tzdata

COPY nginx.conf /etc/nginx/nginx.conf
COPY browser/index.html /usr/share/nginx/html/index.html
RUN ls -alh /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
