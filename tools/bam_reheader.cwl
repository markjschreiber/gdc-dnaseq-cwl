#!/usr/bin/env cwl-runner
#$namespaces:"
  #edam: "http://edamontology.org/"
cwlVersion: v1.0

requirements:
  - class: DockerRequirement
    dockerPull: quay.io/ncigdc/bam_reheader:f9a52a2065d82bbf7ffe10f3658244afe64c00684e7ae3ecfddb8b8befee9e47
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    coresMin: 1
    coresMax: 1
    ramMin: 10000
    ramMax: 10000
    tmpdirMin: $(Math.ceil(1.1 * inputs.input.size / 1048576))
    tmpdirMax: $(Math.ceil(1.1 * inputs.input.size / 1048576))
    outdirMin: $(Math.ceil(1.1 * inputs.input.size / 1048576))
    outdirMax: $(Math.ceil(1.1 * inputs.input.size / 1048576))

class: CommandLineTool

inputs:
  - id: input
    type: File
    format: "edam:format_2572"
    inputBinding:
      prefix: --bam_path

  - id: header
    type: File
    inputBinding:
      prefix: --header_path

outputs:
  - id: output
    type: File
    format: "edam:format_2572"
    outputBinding:
      glob: $(inputs.input.basename)

  - id: log
    type: File
    outputBinding:
      glob: $(inputs.input.basename + ".log")

baseCommand: [/usr/local/bin/bam_reheader]
