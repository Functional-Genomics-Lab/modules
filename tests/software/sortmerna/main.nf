#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { SORTMERNA as SORTMERNA_SE } from '../../../software/sortmerna/main.nf'  addParams( options: [ publish_dir:'test_sortmerna_single_end' ] )
include { SORTMERNA as SORTMERNA_PE } from '../../../software/sortmerna/main.nf'  addParams( options: [ publish_dir:'test_sortmerna_paired_end' ] )

/*
 * Test with single-end data
 */
workflow test_sortmerna_single_end {

    def input = []
    input = [[id: 'test', single_end:true], // meta map
             file('https://github.com/biocore/sortmerna/blob/master/data/test_read.fasta', checkIfExists: true)]

    SORTMERNA_SE (
        input,
        file("${launchDir}/tests/data/fasta//E_coli/NC_010473.fa", checkIfExists: true))
}
/*
 * Test with paired-end data
 */
workflow test_sortmerna_paired_end {

    def input = []
    input = [[id: 'test', single_end:false], // meta map
             file('https://github.com/biocore/sortmerna/blob/master/data/test_read.fasta', checkIfExists: true)]

    SORTMERNA_PE (
        input,
        file('https://github.com/biocore/sortmerna/blob/master/data/test_ref.fasta', checkIfExists: true))

}
