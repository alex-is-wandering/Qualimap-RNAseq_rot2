#!/bin/bash

output_file="compiled_QC_results.txt"

# Loop through each sample directory
for sample_dir in /local/storage/user/project/hereliesdata/QualimapOutput/*/; do
    bam_file=$(basename "$sample_dir")
    echo "Processing sample: $bam_file"

    # Check if results.txt exists in the sample directory
    if [ -f "${sample_dir}/rnaseq_qc_results.txt" ]; then
        # Search for the desired information in results.txt

sample_name=$(grep "bam file =" "${sample_dir}/rnaseq_qc_results.txt" | sed -E 's/.*\/([^_]+)_.*$/\1/')
aligned=$(grep "reads aligned  =" "${sample_dir}/rnaseq_qc_results.txt" | awk '{print $NF}')
total=$(grep "total alignments =" "${sample_dir}/rnaseq_qc_results.txt" | awk '{print $NF}')
notassigned=$(grep "no feature assigned =" "${sample_dir}/rnaseq_qc_results.txt" | awk '{print $NF}')
exonic=$(grep "exonic = " "${sample_dir}/rnaseq_qc_results.txt" | awk '{print $NF}')
intronic=$(grep "intronic =" "${sample_dir}/rnaseq_qc_results.txt" | awk '{print $NF}')
intergenic=$(grep "intergenic =" "${sample_dir}/rnaseq_qc_results.txt" | awk '{print $NF}')
overlappingexon=$(grep "overlapping exon =" "${sample_dir}/rnaseq_qc_results.txt" | awk '{print $NF}')
bias=$(grep "5'-3' bias =" "${sample_dir}/rnaseq_qc_results.txt" | awk '{print $NF}')

        # Write the extracted information into the output file
        echo "Sample Name: $sample_name" >> "$output_file"
        echo "BAM File: $bam_file" >> "$output_file"
	echo "Reads Aligned: $aligned" >> "$output_file"
	echo "Total Alignments: $total" >> "$output_file"
	echo "No Feature Assigned: $notassigned" >> "$output_file"
        echo "Exonic: $exonic" >> "$output_file"
	echo "Intronic: $intronic" >> "$output_file"
	echo "Intergenic: $intergenic" >> "$output_file"
	echo "Overlapping Exon: $overlappingexon" >> "$output_file"
	echo "5'-3' Bias: $bias" >> "$output_file"
        echo "" >> "$output_file"
    else
        echo "results.txt not found in $sample_name"
    fi

    echo "Finished processing sample: $sample_name"
done
