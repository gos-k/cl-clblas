FROM ubuntu:16.10
MAINTAINER gos-k
ENV PATH /usr/local/bin:/root/.roswell/bin:$PATH

RUN apt-get update && \
    apt-get install -y curl libcurl4-gnutls-dev git make gcc bzip2 autoconf automake && \
    apt-get install -y libpocl-dev libclblas-dev clinfo && \
    apt-get autoremove && \
    apt-get clean
RUN clinfo

WORKDIR /tmp
RUN curl -SL https://github.com/snmsts/roswell/archive/release.tar.gz | tar -xzC /tmp/ && \
    cd /tmp/roswell-release && \
    sh bootstrap && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/roswell-release

RUN ros --version
RUN ros run -- --version
RUN ros install prove
RUN git clone https://github.com/gos-k/cl-clblas && \
    cd cl-clblas && \
    run-prove cl-clblas.asd cl-clblas-test.asd

CMD cd /tmp/cl-clblas && \
    git pull && \
    run-prove cl-clblas.asd cl-clblas-test.asd

# see also : https://github.com/snmsts/DockerExperiment/blob/master/cl-devel/Dockerfile
