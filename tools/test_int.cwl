#!/usr/bin/env cwl-runner

cwlVersion: v1.0

requirements:
  - class: DockerRequirement
    dockerPull: quay.io/ncigdc/bc
  - class: InlineJavascriptRequirement

class: CommandLineTool

inputs:
  - id: expected_value
    type: int

  - id: test_value
    type: int

arguments:
  - valueFrom: |
      ${
        return "if (( $(echo \"" + inputs.expected_value + " == " + inputs.test_value + "\" | bc -l) )); then exit 0 ; else exit 1 ; fi";
      }

outputs:
  []

baseCommand: [bash, -c]
