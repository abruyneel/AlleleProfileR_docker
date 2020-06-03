# AlleleProfileR_docker

AlleleProfileR can be run from a docker container, and can be downloaded from the Docker hub repository (abruyneel/alleleprofiler). The container is based on the rocker/verse image and deploys RStudio to use R, and also contains some of the external tools that can be used to process sequencing data, such as samtools (http://www.htslib.org) and bwa (http://bio-bwa.sourceforge.net/bwa.shtml). In addition, an example script and demo data is included. This repository contains the Dockerfile. The source code of AlleleProfileR could be found at https://github.com/abruyneel/AlleleProfileR.

To start the docker container: 
```
docker run --rm -e PASSWORD=crispr -p 8787:8787 abruyneel/alleleprofiler
```

Open a web browser and browse to http://localhost:8787 or http://127.0.0.1:8787, logon on RStudio using the username 'rstudio' and password 'crispr', and run the example.R file.

A local folder (here ~\data) can be mounted to the Docker by adding the -v parameter to the command to initialize Docker. Use this strategy to run AlleleProfileR on your own datasets.
```
docker run --rm -e PASSWORD=crispr -p 8787:8787 -v ~/data:/home/rstudio/data abruyneel/alleleprofiler
```

## Version history

v1.3: 06/03/2020, updated R version (R 4.0.0)

v1.2: 11/02/2019, version of at the time of the publication (R 3.6.1)

## Reference

Bruyneel AAN, Colas AR, Karakikes I, Mercola M (2019) AlleleProfileR: A versatile tool to identify and profile sequence variants in edited genomes. PLOS ONE 14(12): e0226694. https://doi.org/10.1371/journal.pone.0226694
