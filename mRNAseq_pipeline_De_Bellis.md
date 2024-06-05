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
### note: the file used are those in STEP4 and not the rRNA decontamined files but those splitted in STEP_3
trim_galore --paired  -q 20  -o path_output --fastqc SRR_ID_1.fastq SRR_ID_2.fastq

### STEP_7 STAR template indexing
STAR --runMode genomeGenerate --genomeDir path_genome \
          --genomeFastaFiles GRCh38.primary_assembly.genome.fa \
          --sjdbGTFfile gencode.v44.primary_assembly.annotation.gtf \
          --sjdbOverhang 50 --outFileNamePrefix v44_primary_

### STEP_8 STAR alignment
### note: in this step validated (FASTQ_val_1 and FASTQ_val_2) input files produced in STEP6 are used
STAR \
--genomeDir path_genome \
--sjdbGTFfile gencode.v44.primary_assembly.annotation.gtf \
--readFilesIn FASTQ_1_val_1.fq FASTQ_2_val_2.fq \
--outSAMtype BAM Unsorted SortedByCoordinate \
--outFileNamePrefix FASTQ.star \
--quantMode GeneCounts \
--runThreadN 16

### STEP9 feature counts for gene USING subread featureCounts (v2.0.2)
### note: the option -s 0 is used since the file had been produced with unstranded Illumina kit
### the 3 dots indicates all the bam files from case and control samples
featureCounts -T 32 -p --countReadPairs -B -s 0 -C -a gencode.v44.primary_assembly.annotation.gtf -o feature_counts_subread.counts.txt SRR_ID_1.bam ... 


##STEP10 Deseq2 
### the Deseq2 pipeline is available in the repository look the Deseq2_DEG.R file



