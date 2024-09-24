The pipeline described in this repository had been used for mRNA seq analysis in the paper titled:
"Transcriptomic Module Discovery of Diarrhea-Predominant Irritable Bowel Syndrome: A Causal Network Inference Approach. doi: 10.3390/ijms25179322. "

Follow the preprocessing pipeline 00_mRNAseq_pipeline_De_Bellis.md, and for Differential Expressed Genes analysis using  the script 01_Deseq2_DEG.R. 

Instead the file 02_rRNAhomo_sapiens_decontamination.fa contains the human rRNA sequence, that had been used for rRNA decontamination. 


To generate the figure XX of the paper, based on 2 variables dot plot, the code is available on the script named:  created dot_plot_2_variables.R, the input file is the table reactome_54_genes.csv
