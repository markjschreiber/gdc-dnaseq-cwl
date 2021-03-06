#!/usr/bin/env cwl-runner

cwlVersion: v1.0

requirements:
  - $import: readgroup.yaml
  - class: InlineJavascriptRequirement

class: ExpressionTool

inputs:
  - id: readgroup_fastq_se_list
    type:
      type: array
      items: readgroup_no_pu.yaml#readgroup_fastq_se_uuid

  - id: key
    type: string

outputs:
  - id: output
    type: string

expression: |
  ${
    var output = "";
    for (var i = 0; i < inputs.readgroup_fastq_se_list.length; i++) {
      var readgroup = inputs.readgroup_fastq_se_list[i];
      var readgroup_uuid = readgroup[inputs.key];
      output += readgroup_uuid + ',';
    }

    var final_output = output.slice(0, -1); 
    return {'output': final_output}
  }
