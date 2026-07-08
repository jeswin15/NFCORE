
lima --isoseq --dump-clips --peek-guess -j 24 alz.ccs.bam isoseq_primers.fasta alz.demult.bam

isoseq3 refine --require-polya alz.demult.5p--3p.subreadset.xml isoseq_primers.fasta alz.flnc.bam

isoseq3 cluster alz.flnc.bam alz.polished.bam --verbose --use-qvs

pbmm2 align ../hg38.fa alz.polished.transcriptset.xml alz.aligned.bam --preset ISOSEQ --sort -j 24 --log-level INFO

isoseq3 collapse alz.aligned.bam alz.collapsed.gff
