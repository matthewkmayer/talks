FROM gliderlabs/alpine:3.6
RUN apk update && apk upgrade
# Need some build extras to build updated gems:
RUN apk add --no-cache openssl ruby ruby-dev ruby-rdoc ruby-irb gcc build-base libc-dev linux-headers openssl-dev
RUN gem update
# For non-toy applications, use a gemfile and lock these versions.
# Better yet, vendor them.
RUN gem install sinatra cucumber json rspec -V --no-document

RUN mkdir /app

ADD . /app

# Ruby service port:
EXPOSE 9494

# Ruby and delegate pattern:
CMD ruby /app/ruby-service.rb & /app/strangler