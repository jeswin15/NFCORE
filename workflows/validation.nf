workflow VALIDATE {

    take:
    params_map

    main:

    log.info ""
    log.info "Running parameter validation..."

    if (!params_map.input)
        error "Missing required parameter: --input"

    if (!file(params_map.input).exists())
        error "Input BAM not found: ${params_map.input}"

    if (!params_map.primers)
        error "Missing required parameter: --primers"

    if (!file(params_map.primers).exists())
        error "Primer FASTA not found: ${params_map.primers}"

    if (!params_map.genome)
        error "Missing required parameter: --genome"

    if (!file(params_map.genome).exists())
        error "Genome FASTA not found: ${params_map.genome}"

    if (!(params_map.collapse_method in ['isoseq3','tama']))
        error "collapse_method must be 'isoseq3' or 'tama'"

    log.info "✓ Parameter validation passed"
}