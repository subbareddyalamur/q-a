# use n-1 alpine version as base image
FROM alpine:3.20 AS builder

# put below dependencies to install nginx
# gcc - c compiler
# libc-dev - standard C library header files
# openssl-dev, pcre-dev, zlib-dev - for SSL, regex support, and compression features
# libxslt-dev - for XML support
# gd-dev - for image support
# geoip-dev - for GeoIP support
RUN apk add --no-cache \
    gcc \   
    libc-dev \
    make \
    openssl-dev \
    pcre-dev \
    zlib-dev \
    linux-headers \
    curl \
    gnupg \
    libxslt-dev \
    gd-dev \
    geoip-dev

# download nginx source and gpg key
WORKDIR /src
RUN curl -fSL https://nginx.org/download/nginx-1.19.0.tar.gz -o nginx.tar.gz && \
    curl -fSL https://nginx.org/download/nginx-1.19.0.tar.gz.asc -o nginx.tar.gz.asc

# extract, compile nginx with essential modules like SSL, HTTP/2, realip, stub status 
#and remove unnecessary modules like autoindex, browser, geo, scgi, ssi, uwsgi, email modules to reduce image size, minimize attack surface and optimize performance
RUN tar -zxf nginx.tar.gz && \
    cd nginx-1.19.0 && \
    ./configure \
    --prefix=/usr/local/nginx \
    --user=nginx \
    --group=nginx \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_realip_module \
    --with-http_stub_status_module \
    --with-threads \
    --with-file-aio \
    --without-http_autoindex_module \
    --without-http_browser_module \
    --without-http_geo_module \
    --without-http_scgi_module \
    --without-http_ssi_module \
    --without-http_uwsgi_module \
    --without-mail_pop3_module \
    --without-mail_imap_module \
    --without-mail_smtp_module && \
    make && \
    make install

# final stage
FROM alpine:3.20

# add nginx user and group
RUN addgroup -S nginx && \
    adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx nginx

# keep only runtime dependencies
RUN apk add --no-cache \
    pcre \
    openssl \
    tzdata \
    ca-certificates

# copy built nginx from builder stage
COPY --from=builder /usr/local/nginx /usr/local/nginx

# create necessary directories with proper permissions
RUN mkdir -p /var/log/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chmod -R 755 /var/log/nginx && \
    mkdir -p /var/cache/nginx && \
    chown -R nginx:nginx /var/cache/nginx && \
    chmod -R 755 /var/cache/nginx

# copy default nginx configuration
COPY --chown=nginx:nginx nginx.conf /usr/local/nginx/conf/nginx.conf

# set permissions for nginx
RUN chmod 755 /usr/local/nginx/sbin/nginx && \ 
    chown -R nginx:nginx /usr/local/nginx

# add nginx binary to PATH
ENV PATH=/usr/local/nginx/sbin:$PATH

# switch to non-root user
USER nginx

# expose ports
EXPOSE 8080

# start nginx
CMD ["nginx", "-g", "daemon off;"]