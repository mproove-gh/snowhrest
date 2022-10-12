FROM alpine:latest

RUN apk update && apk upgrade \
 && apk add nodejs \
 && apk add npm \
 && apk add git \
 && git clone https://github.com/nicola-attico/hrest.git \
 && mkdir -p {/hrest/certs,/hrest/wallets,/hrest/users}

WORKDIR /hrest
RUN npm update \
 && npm install

EXPOSE 3000

CMD node ./hrest.js
