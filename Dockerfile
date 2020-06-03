FROM rocker/verse:latest

MAINTAINER Arne A.N. Bruyneel <arne.bruyneel@gmail.com>

LABEL \
	version="1.3" \
	description="AlleleProfileR and basic bioinformatics tools"

RUN apt-get update && apt-get install -y \
  bzip2 \
  g++ \
  libbz2-dev \
  liblzma-dev \
  make \
  ncurses-dev \
  wget \
  zlib1g-dev \
  tcl8.6-dev \
  tk8.6-dev 

ENV SAMTOOLS_INSTALL_DIR=/opt/samtools
ENV BWA_INSTALL_DIR=/opt/bwa

WORKDIR /tmp
RUN wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && \
  tar --bzip2 -xf samtools-1.9.tar.bz2

WORKDIR /tmp/samtools-1.9
RUN ./configure --enable-plugins --prefix=$SAMTOOLS_INSTALL_DIR && \
  make all all-htslib && \
  make install install-htslib

WORKDIR $BWA_INSTALL_DIR
RUN git clone https://github.com/lh3/bwa.git && \
	cd bwa && \
	make

WORKDIR /
RUN ln -s $SAMTOOLS_INSTALL_DIR/bin/samtools /usr/bin/samtools && \
  rm -rf /tmp/samtools-1.9 
RUN ln -s $BWA_INSTALL_DIR/bwa/bwa /usr/bin/bwa

RUN R -e "install.packages(c('devtools','BiocManager'), repos = 'http://cran.us.r-project.org')"

RUN R -e "BiocManager::install(c('BiocGenerics', 'Biostrings', 'GenomicAlignments', 'GenomicRanges', 'Rsamtools', 'XVector'))"

RUN R -e "devtools::install_github('abruyneel/AlleleProfileR')"

RUN cd /home/rstudio && \
	mkdir files && \
	cd files && \
	mkdir input && \
	mkdir output && \
	mkdir config && \
	mkdir index && \
	cd index && \
	wget https://raw.githubusercontent.com/abruyneel/AlleleProfileR/master/tests/testthat/files/index/frag.fa && \ 
	cd ../config && \
	wget https://raw.githubusercontent.com/abruyneel/AlleleProfileR/master/tests/testthat/files/config/example_genes.csv && \
	cd ../input && \
	mkdir embryo01 && \
	cd embryo01 && \
	wget https://raw.githubusercontent.com/abruyneel/AlleleProfileR/master/tests/testthat/files/input/embryo01/embryo01.bam 

ADD data/example.R /home/rstudio/

RUN chown -R rstudio /home/rstudio/ 
