#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { HOMER_MAKETAGDIRECTORY as HOMER_MAKETAGDIRECTORY_GROSEQ } from '../maketagdirectory/main.nf' addParams( options: [ publish_dir:'test_groseq_file' ] )

/*
 * GRO-seq Workflow
 * http://homer.ucsd.edu/homer/ngs/groseq/groseq.html
 */
workflow test_groseq_file {

    def input2 = []
    input2 = [ [ id:'test_groseq', single_end:true ], // meta map
              [ file("${baseDir}/input/A.bed", checkIfExists: true),
                file("${baseDir}/input/B.bed", checkIfExists: true) ] ]

    HOMER_MAKETAGDIRECTORY_GROSEQ( input2 )
}

workflow {
    test_groseq_file()
}