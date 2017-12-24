FROM resin/rpi-raspbian:jessie-20171110 as base

### Now install some additional parts we will need for the build
RUN apt-get update -y && \
	apt-get install -y gcc make curl libssl-dev && \
	apt-get clean && \
	groupadd -r fossil -g 433 && \
	useradd -u 431 -r -g fossil -d /opt/fossil -s /sbin/nologin -c "Fossil user" fossil

RUN curl "http://core.tcl.tk/tcl/tarball/tcl-src.tar.gz?name=tcl-src&uuid=release" | tar zx
RUN cd tcl-src/unix && \
	./configure --prefix=/usr --disable-threads && \
	make && \
	make install

### If you want to build "release", change the next line accordingly.
ENV FOSSIL_INSTALL_VERSION trunk
# version-2.4

RUN curl "http://www.fossil-scm.org/index.html/tarball/fossil-src.tar.gz?name=fossil-src&uuid=${FOSSIL_INSTALL_VERSION}" | tar zx
WORKDIR /fossil-src
RUN ./configure --disable-fusefs --json --with-th1-docs --with-th1-hooks --with-tcl=1
RUN make && \
	strip fossil && \
	chmod a+rx fossil
	
FROM resin/rpi-raspbian:jessie-20171110

RUN apt-get update -y && \
	apt-get install -y libssl1.0.0 libtcl8.6 && \
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
