### Here is describe the pipeline to find the Differential Expressed Genes (DEGs)

#### STEP_1 import libraries
library(tidyverse)
library(DESeq2)
library(ggplot2)


#### STEP1_ upload and formatting counts dataframe
data <- read.table("feature_counts_subread.counts.txt", header=T, row.names=1) ### upload raw counts
meta <- read.table("decoder_GSE146853_Healthy_vs_Diarrhea.txt", header=T, row.names=1) ### upload metadata
meta <- meta[order(meta$group.ID), ] ### Sort the DataFrame meta based on the column group.ID

all(colnames(data) %in% rownames(meta)) ## this command checks that the column names of the data and meta dataframes are the same
all(colnames(data) == rownames(meta)) ## Check if each column name in 'data' exactly matches a row name in 'meta'

dds <- DESeqDataSetFromMatrix(countData = data, colData = meta, design = ~ group.ID) ## Create DESeqDataSet

 
rld <- rlogTransformation(dds, blind = TRUE) # rlogTransformation
pca_data <- DESeq2::plotPCA(rld, intgroup = "Gender", returnData = TRUE) # data generation for PCA plot
my_colors <- c("blue", "red") # define the colors
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Gender)) +
  geom_point(size = 3) +
  scale_color_manual(values = my_colors) +
  theme_minimal() +
  labs(title = "PCA Plot", x = "PC1", y = "PC2") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) ### generate PCA plot
print(p) ## PCA visualization

keep <- rowSums(counts(dds) >= 10) >=10 ### delete rows if the minimum counts of the gene for each patient is less than 10
dds <- dds[keep,]## count dataframe filtering
dds <- DESeq(dds)# Run DESeq2 differential expression analysis
contrast <- c("group.ID", "Diarrhea", "Healthy")
res <- results(dds, contrast = contrast)
write.csv(res, "D:/Desktop/Deseq2_gender.csv")### after saving the res dataframe to find DEGs,data are filtered for log2fc>=1 and log2fc<=-1 and pvalue <0.5;


#### create normalized count dataframe for SEMgraph statistical analysis

norm_counts <- counts(dds, normalized = T)
norm_counts <- as.data.frame(norm_counts)


