#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { HOMER_ANNOTATEPEAKS } from '../../../../software/homer/annotatepeaks/main.nf' addParams( options: [:] )

workflow test_homer_annotatepeaks {

    def input = []
    input = [[id: 'test', single_end: false], // meta map
             [file("${launchDir}/tests/data/bed/A.bed", checkIfExists: true),
              file("${launchDir}/tests/data/bed/B.bed", checkIfExists: true)]]

      HOMER_ANNOTATEPEAKS ( input )
}

