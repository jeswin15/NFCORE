process PBMM2 {
    conda "${projectDir}/envs/environment.yml"


    tag "${sample_id}"

    publishDir "${params.outdir}/03_alignment/pbmm2", mode: 'copy'

    cpus params.pbmm2_cpus

    input:
        tuple val(sample_id), path(cleaned_fasta)
        path genome

    output:
        tuple val(sample_id), path("${sample_id}.pbmm2.sorted.bam"), emit: aligned_bam

    script:
    """
    pbmm2 align \
        ${genome} \
        ${cleaned_fasta} \
        ${sample_id}.pbmm2.sorted.bam \
        --preset ISOSEQ \
        --sort \
        -j ${task.cpus}
    """
}