###
#   Dockerfile for Fossil
###
FROM resin/rpi-raspbian:wheezy

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

RUN curl "http://www.fossil-scm.org/index.html/tarball/fossil-src.tar.gz?name=fossil-src&uuid=trunk” | tar zx
WORKDIR /fossil-src
RUN ./configure --disable-fusefs --json --with-th1-docs --with-th1-hooks --with-tcl
RUN make && \
	strip fossil && \
	chmod a+rx fossil && \
	mkdir dist && \
	cp fossil dist

COPY /Dockerfile.run /fossil-src/dist/Dockerfile

WORKDIR /fossil-src/dist

CMD tar -cf - .