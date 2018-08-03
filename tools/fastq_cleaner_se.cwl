#!/usr/bin/env cwl-runner

cwlVersion: v1.0

requirements:
  - class: DockerRequirement
    dockerPull: quay.io/ncigdc/fastq_cleaner:latest
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    coresMin: 1
    coresMax: 1
    ramMin: 20000
    ramMax: 20000
    tmpdirMin: $(Math.ceil(1.1 * inputs.fastq.size / 1048576))
    tmpdirMax: $(Math.ceil(1.1 * inputs.fastq.size / 1048576))
    outdirMin: $(Math.ceil(1.1 * inputs.fastq.size / 1048576))
    outdirMax: $(Math.ceil(1.1 * inputs.fastq.size / 1048576))

class: CommandLineTool

inputs:
  - id: fastq
    type: File
    format: "edam:format_2182"
    inputBinding:
      prefix: --fastq

outputs:
  - id: cleaned_fastq
    type: File
    format: "edam:format_2182"
    outputBinding:
      glob: $(inputs.fastq.basename)

baseCommand: [/usr/local/bin/fastq_cleaner]
