FROM golang:1.9-alpine
MAINTAINER Roman Atachiants "roman@misakai.com"

# Copy the directory into the container.
RUN mkdir -p /go/src/github.com/emitter-io/emitter/
WORKDIR /go/src/github.com/emitter-io/emitter/
ADD . /go/src/github.com/emitter-io/emitter/

# Download and install any required third party dependencies into the container.
RUN apk add --no-cache g++ \ 
&& go-wrapper install \
&& apk del g++

# For let's encrypt
RUN apk update \
    && apk add ca-certificates wget \
    && update-ca-certificates \
    && apk add --no-cache openssl socat \
    && wget -O -  https://get.acme.sh | sh

# Expose emitter ports
EXPOSE 4000
EXPOSE 8080
EXPOSE 8443
# For let's encrypt .acme.sh standalone server
EXPOSE 80

# Start the broker
CMD ["go-wrapper", "run"]
