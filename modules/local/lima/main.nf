process LIMA {
    conda "${projectDir}/envs/environment.yml"


    stageInMode 'copy'

    tag "${sample_id}"

    publishDir "${params.outdir}/01_preprocessing/lima", mode: 'copy'

    cpus params.lima_cpus

    input:
        tuple val(sample_id), path(ccs_bam)
        path primers

    output:
        tuple val(sample_id), path("${sample_id}.fl.*.bam"), emit: fl_bam

    script:
    """
    lima \
        --peek-guess \
        --isoseq \
        ${ccs_bam} \
        ${primers} \
        ${sample_id}.fl.bam
    """
}