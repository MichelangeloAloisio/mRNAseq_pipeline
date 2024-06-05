# mRNAseq_pipeline used at IRCCS Saverio De Bellis 
The RNA-seq pipeline used in the scientific paper titled "Transcriptomic pathway discovery in Diarrhea-Predominant Irritable Bowel Syndrome: A causal network inference approach" is available.
The full pipeline is composed of XXX steps: 

### STEP_1 Download files using SRA toolkit 
prefetch -v -O path_output SRR_ID
### STEP_2 Check if downloaded files are complete before splitting
vdb-validate  SRR_ID >SRR_ID_LOG.txt
### STEP_3 split SRR_ID.sra files in fastq1 and fastq2
fastq-dump --split-files  --outdir path_outdir SRR_ID.sra
