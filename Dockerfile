FROM nginx:stable-alpine

RUN apk add --update bash

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
