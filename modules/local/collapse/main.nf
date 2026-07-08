process COLLAPSE {
    conda "${projectDir}/envs/environment.yml"


    tag "${sample_id}"

    publishDir "${params.outdir}/04_annotation/collapse", mode: 'copy'

    cpus 4

    input:
        tuple val(sample_id), path(aligned_bam)
        path genome

    output:
        tuple val(sample_id), path("${sample_id}.collapse.gff"), emit: gff

    script:
    """
    isoseq3 collapse \
        --do-not-collapse-extra-5exons \
        ${aligned_bam} \
        ${genome} \
        ${sample_id}.collapse.gff
    """
}

process TAMA_COLLAPSE {
    conda "${projectDir}/envs/environment.yml"


    tag "${sample_id}"

    publishDir "${params.outdir}/04_annotation/tama_collapse", mode: 'copy'

    cpus 4

    input:
        tuple val(sample_id), path(aligned_bam)
        path genome

    output:
        tuple val(sample_id), path("${sample_id}.bed"), emit: bed

        path("${sample_id}_trans_read.bed"), emit: trans_read
        path("${sample_id}_read.txt"), emit: read_info
        path("${sample_id}_report.txt"), emit: report
        path("${sample_id}_trans_report.txt"), emit: trans_report
        path("${sample_id}_variants.txt"), emit: variants
        path("${sample_id}_varcov.txt"), emit: varcov
        path("${sample_id}_polya.txt"), emit: polya
        path("${sample_id}_local_density_error.txt"), emit: lde
        path("${sample_id}_strand_check.txt"), emit: strand

    script:
    """
    python ${params.tama_collapse_script}\
        -s ${aligned_bam} \
        -f ${genome} \
        -p ${sample_id} \
        -b BAM
    """
}