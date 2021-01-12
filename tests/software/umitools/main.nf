#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { UMITOOLS_DEDUP } from '../../../software/umitools/dedup/main.nf' addParams( options: [:] )
include { UMITOOLS_EXTRACT as UMITOOLS_EXTRACT_SE } from '../../../software/umitools/extract/main.nf' addParams( options: [publish_dir:'test_umitools_single_end', args:'--bc-pattern=NNNNNNNNN']  )
include { UMITOOLS_EXTRACT as UMITOOLS_EXTRACT_PE } from '../../../software/umitools/extract/main.nf' addParams( options: [publish_dir:'test_umitools_paired_end', args:'--bc-pattern=NNNNNNNNN --bc-pattern2=NNNNNNNNN']  )

/*
 * Test with single-end data
 */

workflow test_umitools_dedup {

    def input = []
    input = [ [ id:'test', single_end:true ], // meta map
              file("${launchDir}/tests/data/bam/test.single_end.sorted.bam", checkIfExists: true),
              file("${launchDir}/tests/data/bam/test.single_end.sorted.bam.bai", checkIfExists: true) ]

    UMITOOLS_DEDUP ( input )
}


workflow test_umitools_extract_single_end {
    def input = []
    input = [ [ id:'test', single_end:true ], // meta map
              file("${launchDir}/tests/data/fastq/rna/test_R1.fastq.gz", checkIfExists: true) ]
    UMITOOLS_EXTRACT_SE ( input )
}
workflow test_umitools_extract_paired_end {
    def input = []
    input = [ [ id:'test', single_end:false ], // meta map
              [file("${launchDir}/tests/data/fastq/rna/test_R1.fastq.gz", checkIfExists: true),
              file("${launchDir}/tests/data/fastq/rna/test_R2.fastq.gz", checkIfExists: true)]]
    UMITOOLS_EXTRACT_PE ( input )
}

