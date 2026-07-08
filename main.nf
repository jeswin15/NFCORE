nextflow.enable.dsl = 2

include { VALIDATE } from './workflows/validation'
include { ISOSEQANNOTATE } from './workflows/isoseqannotate'

workflow {

    VALIDATE(params)

    log.info """
============================================================
                 IsoSeqAnnotate v0.95
============================================================

Run Information
------------------------------------------------------------
Input BAM        : ${params.input}
Primers          : ${params.primers}
Genome           : ${params.genome}
Collapse Method  : ${params.collapse_method}
Output Directory : ${params.outdir}

Resources
------------------------------------------------------------
LIMA CPUs        : ${params.lima_cpus}
REFINE CPUs      : ${params.refine_cpus}
CLUSTER2 CPUs    : ${params.cluster_cpus}
PBMM2 CPUs       : ${params.pbmm2_cpus}
Collapse CPUs    : ${params.collapse_cpus}

============================================================
Starting pipeline...
============================================================
"""

    ISOSEQANNOTATE()
}