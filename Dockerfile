ARG ARCH=
FROM ${ARCH}alpine:3.14 as base

RUN apk add libressl-dev sqlite-dev tcl-dev zlib-dev curl alpine-sdk

### If you want to build "release", change the next line accordingly.
#ENV FOSSIL_INSTALL_VERSION trunk
ENV FOSSIL_INSTALL_VERSION version-2.16

RUN curl "https://www.fossil-scm.org/home/tarball/fossil-src.tar.gz?name=fossil-src&uuid=${FOSSIL_INSTALL_VERSION}" | tar zx
WORKDIR /fossil-src
RUN ./configure --disable-fusefs --json --with-th1-docs --with-th1-hooks --with-tcl=1
RUN make && \
	strip fossil && \
	chmod a+rx fossil
	
FROM ${ARCH}alpine:3.14

RUN apk add --no-cache libressl tcl

COPY --from=base /fossil-src/fossil /usr/bin/

RUN mkdir -p /opt/fossil
ENV HOME /opt/fossil

EXPOSE 8080

CMD ["/usr/bin/fossil", "server", "--create", "--user", "admin", "/opt/fossil/repository.fossil"]
