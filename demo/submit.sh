curl -X POST "https://ec2-3-224-114-81.compute-1.amazonaws.com/api/workflows/v1" \
	-H "accept: application/json" \
	-H "Content-Type: multipart/form-data" \
	-F "workflowSource=@alignment_workflow.pack.cwl" \
	-F "workflowInputs=@alignment_workflow.json;type=application/json" \
	-F "workflowType=CWL" \
	-F "workflowTypeVersion=v1.0"
