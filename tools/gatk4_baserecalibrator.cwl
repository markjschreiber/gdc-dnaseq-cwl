#!/usr/bin/env cwl-runner

cwlVersion: v1.0

requirements:
  - class: DockerRequirement
    dockerPull: quay.io/ncigdc/gatk:edf58a14fc8d23fe98a97c372c74bbdd601696f894b4605586d0d4e2a4f30fe3
  - class: InlineJavascriptRequirement

class: CommandLineTool

inputs:
  - id: input
    format: "edam:format_2572"
    type: File
    inputBinding:
      prefix: --input
    secondaryFiles:
      - ^.bai

  - id: known-sites
    format: "edam:format_3016"
    type: File
    inputBinding:
      prefix: --known-sites
    secondaryFiles:
      - .tbi

  - id: reference
    format: "edam:format_1929"
    type: File
    inputBinding:
      prefix: --reference
    secondaryFiles:
      - .fai
      - ^.dict

  - id: TMP_DIR
    type: string
    default: "."
    inputBinding:
      prefix: --TMP_DIR

outputs:
  - id: output_grp
    type: File
    outputBinding:
      glob: $(inputs.input.nameroot + "_bqsr.grp")

arguments:
  - valueFrom: $(inputs.input.nameroot + "_bqsr.grp")
    prefix: --output
    separate: true

baseCommand: [java, -jar, /usr/local/bin/gatk-package-4.0.4.0-local.jar, BaseRecalibrator]
