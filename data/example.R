# set working directory
setwd("/home/rstudio")

# load library
library(AlleleProfileR)

# process example data
samples <- AlleleProfileR.read.folders(type = "bam")
  
crispr_config <- AlleleProfileR.setup(samples = samples, genes = "files/config/example_genes.csv",
                                        index = "files/index/frag.fa", cutoff = 0.005, ignore.snp = F,
                                        cut.range = 0, ignore.single = T, cutoff.large = 25, ignore.chimeric = F,
                                        chimeric.max.insertion.size = 50, suppress.messages = T)
  

AlleleProfileR.batch(crispr_config, cores=1, subset = list(c(1),c(1:4)))

# plot
AlleleProfileR.plot(crispr_config, 1, 1)


