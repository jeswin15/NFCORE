process TAMA_CLEANUP {
    conda "${projectDir}/envs/environment.yml"

    tag "${sample_id}"

    publishDir "${params.outdir}/02_cleanup/tama_cleanup", mode: 'copy'

    input:
        tuple val(sample_id), path(transcripts_fasta)

    output:
        tuple val(sample_id), path("${sample_id}.transcripts.fa"), emit: cleaned_fasta

    script:
    """
    python ${params.tama_cleanup_script} \
        -f ${transcripts_fasta} \
        -p ${sample_id}.transcripts \
        -m 200
    """
}