#!/bin/bash

#designate qualimap output directory
output_dir="/QualimapOutput" #CHECK WORKING DIRECTORY
bam_folder="/local/storage/user/project/hereliesdata/outputs/STAR"
gtf_file="/local/storage/user/alignments/alignment_annotation.gtf"

for bam_file in "$bam_folder"/*.bam; do
    # Check if file is a regular file
    if [ -f "$bam_file" ]; then
        # Get the filename (sample name) from the BAM path
        sample_name=$(basename "$bam_file" .bam)
        
        # Output report directory
        output_report="${output_dir}/qualimap_${sample_name}"
        
        # Run Qualimap RNA-seq tool for each BAM file with the same GTF file
        /local/storage/user/folders/qualimap_v2.3/qualimap --paired --java-mem-size=10G rnaseq -bam "$bam_file" -gtf "$gtf_file" -outdir "$output_report"
    fi
done
