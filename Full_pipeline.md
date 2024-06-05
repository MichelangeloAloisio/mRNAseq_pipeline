# mRNAseq_pipeline used at IRCCS Saverio De Bellis 
The RNA-seq Full pipeline used in the scientific paper titled "Transcriptomic pathway discovery in Diarrhea-Predominant Irritable Bowel Syndrome: A causal network inference approach" is available.
The full pipeline is composed of XXX steps: 

### STEP_1 Download fastq files from Gene Expression Omnibus (GEO) using SRA toolkit version 3.0.0 
prefetch -v -O path_output SRR_ID

### STEP_2 Check if downloaded files are complete before splitting
vdb-validate  SRR_ID >SRR_ID_LOG.txt

### STEP_3 split SRR_ID.sra files in fastq1 and fastq2
fastq-dump --split-files  --outdir path_outdir SRR_ID.sra

### STEP_4 Quality Control pre-trimming (FastQC v0.11.8)
fastqc SRR_ID_1.fastq -o output_path
fastqc SRR_ID_2.fastq -o output_path

### STEP_5 rRNA amount Sequence Expression AnaLyzer Seal from BBtools (v39.01), rRNAhomo_sapiens_decontamination.fa file is available in the repository
seal.sh -Xmx50G rcomp=t  threads=16 overwrite=true ref=rRNAhomo_sapiens_decontamination.fa \
in=SRR_ID_1.fastq in2=SRR_ID_2.fastq \
out1=EXCLUDED_SRR_ID_2.fastq out2=EXCLUDED_SRR_ID_2.fastq \
outu1=DECONTAMINED_SRR_ID_2.fastq outu2=DECONTAMINED_SRR_ID_2.fastq

### STEP_6 Trimming  using version trim_galore 0.5.0, and quality control after trimming using fastqc 
### note: the file used are those in STEP4 and not the rRNA decontamined files
trim_galore --paired  -q 20  -o path_output --fastqc SRR_ID_1.fastq SRR_ID_2.fastq
