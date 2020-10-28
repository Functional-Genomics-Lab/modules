#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { HOMER_MAKETAGDIRECTORY as HOMER_MAKETAGDIRECTORY_GROSEQ } from '../maketagdirectory/main.nf' addParams( options: [ publish_dir:'test_groseq_file' ] )
include { HOMER_ANNOTATEPEAKS as HOMER_ANNOTATEPEAKS_GROSEQ } from '../annotatepeaks/main.nf' addParams( options: [ publish_dir:'test_groseq_file' ] )
include { HOMER_FINDPEAKS as HOMER_FINDPEAKS_GROSEQ } from '../findpeaks/main.nf' addParams( options: [ publish_dir:'test_groseq_file' ] )
include { HOMER_MAKEUCSCFILE as HOMER_MAKEUCSCFILE_GROSEQ } from '../makeucscfile/main.nf' addParams( options: [ publish_dir:'test_groseq_file' ] )

/*
 * GRO-seq Workflow
 * http://homer.ucsd.edu/homer/ngs/groseq/groseq.html
 */
workflow test_groseq_file {

    def input2 = []
    input2 = [ [ id:'test_groseq', single_end:true ], // meta map
              [ file("${baseDir}/input/A.bed", checkIfExists: true),
                file("${baseDir}/input/B.bed", checkIfExists: true) ] ]

    // HOMER_CONFIGUREHOMER_GROSEQ( )
    HOMER_MAKETAGDIRECTORY_GROSEQ( input2 )
    // FIXME HOMER_ANNOTATEPEAKS_GROSEQ( HOMER_MAKETAGDIRECTORY_GROSEQ.out.tagdir )
    HOMER_MAKEUCSCFILE_GROSEQ( HOMER_MAKETAGDIRECTORY_GROSEQ.out.tagdir )
    HOMER_FINDPEAKS_GROSEQ( HOMER_MAKETAGDIRECTORY_GROSEQ.out.tagdir )
}

workflow {
    test_groseq_file()
}
