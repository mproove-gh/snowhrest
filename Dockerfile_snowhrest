FROM alpine:latest
ENV HEDERA_USER=hedera

RUN addgroup -g 9999 $HEDERA_USER \
 && adduser -u 9999 -G $HEDERA_USER -D $HEDERA_USER

RUN apk update && apk upgrade \
 && apk add nodejs \
 && apk add npm \
 && apk add git \
 && git clone https://github.com/nicola-attico/hrest.git \
 && mkdir -p {/hrest/certs,/hrest/wallets,/hrest/users}

WORKDIR /hrest
RUN npm update \
 && npm install

RUN chown -R $HEDERA_USER:$HEDERA_USER /hrest

EXPOSE 3000
USER $HEDERA_USER
CMD ["node", "./hrest.js"]
