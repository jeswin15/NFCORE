process CLUSTER2 {
    conda "${projectDir}/envs/environment.yml"


    tag "${sample_id}"

    publishDir "${params.outdir}/01_preprocessing/cluster2", mode: 'copy'

    cpus params.cluster_cpus

    input:
        tuple val(sample_id), path(flnc_bam)

    output:
        tuple val(sample_id), path("${sample_id}.transcripts.bam"), emit: transcripts_bam
        tuple val(sample_id), path("${sample_id}.transcripts.fasta"), emit: transcripts_fasta

    script:
    """
    isoseq3 cluster2 \
        ${flnc_bam} \
        ${sample_id}.transcripts.bam \
        -j ${task.cpus}

    samtools fasta \
        ${sample_id}.transcripts.bam \
        > ${sample_id}.transcripts.fasta
    """
}