### Here is describe the pipeline to find the Differential Expressed Genes (DEGs)

#### STEP_1 import libraries
library(tidyverse)


#### STEP1_ upload and formatting counts dataframe
data <- read.table("feature_counts_subread.counts.txt", header=T, row.names=1) ### upload raw counts
meta <- read.table("decoder_GSE146853_Healthy_vs_Diarrhea.txt", header=T, row.names=1) ### upload metadata
meta <- meta[order(meta$group.ID), ] ### Sort the DataFrame meta based on the column group.ID

all(colnames(data) %in% rownames(meta)) ## this command checks that the column names of the data and meta dataframes are the same
all(colnames(data) == rownames(meta)) ## Check if each column name in 'data' exactly matches a row name in 'meta'


