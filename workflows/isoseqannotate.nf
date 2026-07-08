nextflow.enable.dsl = 2

include { LIMA } from '../modules/local/lima'
include { REFINE } from '../modules/local/refine'
include { CLUSTER2 } from '../modules/local/cluster2'
include { TAMA_CLEANUP } from '../modules/local/tama_cleanup'
include { PBMM2 } from '../modules/local/pbmm2'
include { COLLAPSE } from '../modules/local/collapse'
include { TAMA_COLLAPSE} from '../modules/local/collapse'
workflow ISOSEQANNOTATE {

    main:

    log.info "Collapse method = ${params.collapse_method}"

    if (!(params.collapse_method in ['isoseq3', 'tama'])) {
    error "collapse_method must be either 'isoseq3' or 'tama'"
}

    Channel
        .fromPath(params.input)
        .map { bam ->
            tuple(bam.baseName, bam)
        }
        .set { ch_subreads }

    primers = file(params.primers)

    LIMA(
        ch_subreads,
        primers
    )


    REFINE(
    LIMA.out.fl_bam,
    primers
    )
    CLUSTER2(
    REFINE.out.flnc_bam
    )
    TAMA_CLEANUP(
    CLUSTER2.out.transcripts_fasta
    )
    Channel
    .fromPath(params.genome, checkIfExists: true)
    .set { ch_genome }

    PBMM2(
        TAMA_CLEANUP.out.cleaned_fasta,
        ch_genome
    )
   
    if (params.collapse_method == "isoseq3") {
        COLLAPSE(
        PBMM2.out.aligned_bam,
        ch_genome
    )
     final_annotation = COLLAPSE.out.gff


    }
    else if (params.collapse_method == "tama") {
        TAMA_COLLAPSE(
        PBMM2.out.aligned_bam,
        ch_genome
    )
     final_annotation = TAMA_COLLAPSE.out.bed


    }
    else {
        error "collapse_method must be 'isoseq3' or 'tama'"

    }
    

    emit:
    gff = final_annotation

}
