version 1.0

workflow extract_samples_from_mvcf {
	input {
		File input_vcf
		Array[String] sample_names
		String bcftools_docker
	}

	scatter(sample_name in sample_names) {
		call ViewSample {
			input:
				sample_name = sample_name,
				docker_image = bcftools_docker,
				input_vcf = input_vcf
		}
	}

}

task ViewSample {
	input {
		String sample_name
		String docker_image
		File input_vcf
	}

	String output_vcf_name = "~{sample_name}.vcf.gz"

	command {
		bcftools view -Oz -s ~{sample_name} ~{input_vcf} > ~{output_vcf_name}
	}
	output {
		File output_vcf = "~{output_vcf_name}"
	}

	runtime {
	    docker: docker_image,
    	memory: "2 GiB",
    	cpu: 1
	}
}
