#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { HOMER_ANNOTATEPEAKS } from '../../../../software/homer/annotatepeaks/main.nf' addParams( options: [:] )

workflow test_homer_annotatepeaks {

    def input = []
    input = [[id: 'test'], // meta map
             // FIXME Should be peakfiles
             [file("${launchDir}/tests/data/bed/A.bed", checkIfExists: true),
              file("${launchDir}/tests/data/bed/B.bed", checkIfExists: true)]]

    fasta = file("${launchDir}/tests/data/fasta/E_coli/NC_010473.fa", checkIfExists: true)
    gtf = file("${launchDir}/tests/data/gff/a.gtf", checkIfExists: true)

    HOMER_ANNOTATEPEAKS ( input, fasta, gtf)
}

