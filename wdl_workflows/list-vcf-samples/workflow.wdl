workflow list_vcf_samples {
	input {
		File input_vcf
	}

	String output_vcf_name = "${input_vcf}.samples.txt"

	call ListSamples {
		input:
			input_vcf = input_vcf
	}

	output {
		File output_file = ListSamples.output_file
	}
}

task ListSamples {
	input {
		File input_vcf
	}

	String output_file_name = "${input_vcf}.samples.txt"

	command {
		bcftools query -l ${input_vcf} > ${output_file_name}
	}
	output {
		File output_file = "${output_file_name}"
	}
	runtime {
    	docker: "public.ecr.aws/biocontainers/bcftools:1.20--h8b25389_0",
    	memory: "~2 GiB",
    	cpu: 2
  	}	
}