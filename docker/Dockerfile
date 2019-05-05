
ARG UBUNTU_VERSION=bionic

FROM lsiobase/ubuntu:${UBUNTU_VERSION}

LABEL AUTHOR=songchenwen<me@songchenwen.com>

RUN apt-get update 

run apt install -y --no-install-recommends curl wget git bash

# gcc for cgo
RUN apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		pkg-config \
	&& rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.10

RUN set -eux; \
	\
# this "case" statement is generated via "update.sh"
	dpkgArch="$(dpkg --print-architecture)"; \
	case "${dpkgArch##*-}" in \
		amd64) goRelArch='linux-amd64' ;; \
		armhf) goRelArch='linux-armv6l' ;; \
		arm64) goRelArch='linux-arm64' ;; \
		i386) goRelArch='linux-386' ;; \
		ppc64el) goRelArch='linux-ppc64le' ;; \
		s390x) goRelArch='linux-s390x' ;; \
		*) goRelArch='src'; \
			echo >&2; echo >&2 "warning: current architecture ($dpkgArch) does not have a corresponding Go binary release; will be building from source"; echo >&2 ;; \
	esac; \
	\
	url="https://golang.org/dl/go${GOLANG_VERSION}.${goRelArch}.tar.gz"; \
	wget -O go.tgz "$url"; \
	tar -C /usr/local -xzf go.tgz; \
	rm go.tgz; \
	\
	if [ "$goRelArch" = 'src' ]; then \
		echo >&2; \
		echo >&2 'error: UNIMPLEMENTED'; \
		echo >&2 'TODO install golang-any from jessie-backports for GOROOT_BOOTSTRAP (and uninstall after build)'; \
		echo >&2; \
		exit 1; \
	fi; \
	\
	export PATH="/usr/local/go/bin:$PATH"; \
	go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

# above from golang strech docker

WORKDIR /go/src/app

run chown abc:abc /go/src/app

env COOKIES=Please_insert_cookies
env IGNORE=""

run echo fs.inotify.max_user_watches=1048576 | tee -a /etc/sysctl.conf && sysctl -p

copy . .

run go get github.com/songchenwen/gphotosuploader

run chmod a+x run.sh

RUN chown abc:abc /app
WORKDIR /app

CMD ["/go/src/app/run.sh"]
