process REFINE {
    conda "${projectDir}/envs/environment.yml"


    tag "${sample_id}"

    publishDir "${params.outdir}/01_preprocessing/refine", mode: 'copy'

    cpus params.refine_cpus

    input:
        tuple val(sample_id), path(fl_bam)
        path primers

    output:
        tuple val(sample_id), path("${sample_id}.flnc.bam"), emit: flnc_bam

    script:
    """
    isoseq3 refine \
        ${fl_bam} \
        ${primers} \
        ${sample_id}.flnc.bam
    """
}