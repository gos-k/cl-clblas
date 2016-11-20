FROM ubuntu:16.10
MAINTAINER gos-k <mag4.elan@gmail.com>
ENV PATH /usr/local/bin:/root/.roswell/bin:$PATH
RUN apt-get update

RUN apt-get install -y curl libcurl4-gnutls-dev git make gcc bzip2 autoconf automake 
RUN apt-get install -y libpocl-dev clinfo libclblas-dev
RUN apt-get autoremove && apt-get clean
RUN clinfo

RUN curl -SL https://github.com/snmsts/roswell/archive/release.tar.gz | tar -xzC /tmp/
WORKDIR /tmp/roswell-release
RUN sh bootstrap && ./configure && make && make install
RUN rm -rf /tmp/roswell-release

RUN ros --version
RUN ros run -- --version
RUN ros install prove

WORKDIR /tmp
CMD git clone https://github.com/gos-k/cl-clblas && cd cl-clblas && run-prove cl-clblas.asd cl-clblas-test.asd 

# see also : https://github.com/snmsts/DockerExperiment/blob/master/cl-devel/Dockerfile
