FROM arm32v7/debian:9.4-slim as base

### Now install some additional parts we will need for the build
RUN apt-get update -y && \
	apt-get install -y build-essential curl libssl-dev zlib1g-dev && \
	apt-get clean && \
	groupadd -r fossil -g 433 && \
	useradd -u 431 -r -g fossil -d /opt/fossil -s /sbin/nologin -c "Fossil user" fossil

RUN curl "http://core.tcl.tk/tcl/tarball/tcl-src.tar.gz?name=tcl-src&uuid=release" | tar zx
RUN cd tcl-src/unix && \
	./configure --prefix=/usr --disable-threads && \
	make && \
	make install

### If you want to build "release", change the next line accordingly.
#ENV FOSSIL_INSTALL_VERSION trunk
ENV FOSSIL_INSTALL_VERSION version-2.6

RUN curl "http://www.fossil-scm.org/index.html/tarball/fossil-src.tar.gz?name=fossil-src&uuid=${FOSSIL_INSTALL_VERSION}" | tar zx
WORKDIR /fossil-src
RUN ./configure --disable-fusefs --json --with-th1-docs --with-th1-hooks --with-tcl=1
RUN make && \
	strip fossil && \
	chmod a+rx fossil
	
FROM arm32v7/debian:9.4-slim

RUN apt-get update -y && \
	apt-get install -y libssl1.1 libtcl8.6 && \
	apt-get clean && \
	groupadd -r fossil -g 433 && \
	useradd -u 431 -r -g fossil -d /opt/fossil -s /sbin/nologin -c "Fossil user" fossil && \
	mkdir -p /opt/fossil && \
	chown fossil:fossil /opt/fossil

COPY --from=base /fossil-src/fossil /usr/bin/

USER fossil

ENV HOME /opt/fossil

EXPOSE 8080

CMD ["/usr/bin/fossil", "server", "--create", "--user", "admin", "/opt/fossil/repository.fossil"]
