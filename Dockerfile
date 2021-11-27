FROM alpine as builder

RUN apk add bash \
            curl && \
    curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh --output get.sh && \
    chmod a+x ./get.sh && \
    ./get.sh \
