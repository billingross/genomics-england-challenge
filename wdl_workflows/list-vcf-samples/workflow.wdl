version 1.0

workflow list_vcf_samples {
	input {
		File input_vcf
		String bcftools_docker
	}

	String output_vcf_name = "~{input_vcf}.samples.txt"

	call ListSamples {
		input:
			input_vcf = input_vcf,
			docker_image = bcftools_docker
	}

	output {
		File output_file = ListSamples.output_file
	}
}

task ListSamples {
	input {
		File input_vcf
		String docker_image
	}

	String output_file_name = "~{input_vcf}.samples.txt"

	command {
		bcftools query -l ~{input_vcf} > ~{output_file_name}
	}
	output {
		File output_file = "~{output_file_name}"
	}
	runtime {
    	docker: docker_image,
    	memory: "2 GiB",
    	cpu: 2
  	}	
}