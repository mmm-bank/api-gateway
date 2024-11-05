FROM openresty/openresty:alpine

RUN apk add --no-cache build-base wget

RUN wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz
RUN tar zxpf luarocks-3.11.1.tar.gz
WORKDIR /luarocks-3.11.1
RUN ./configure && make && make install

RUN luarocks install lua-resty-jwt

COPY ./check_jwt.lua /usr/local