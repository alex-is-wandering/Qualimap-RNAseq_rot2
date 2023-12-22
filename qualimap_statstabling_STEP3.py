columns = ["Sample Name", "BAM File", "Reads Aligned", "Total Alignments", "No Feature Assigned", "Exonic", "Intronic", "Intergenic","Overlapping Exon","5'-3' Bias"]

# Function to extract numeric values from strings like "(46.7%)"
def extract_numeric_value(value):
    return value.split('(')[1].split(')')[0]

# Open the file containing the results and the output file for the table
with open('compiled_QC_results.txt', 'r') as file, open('tabled_QC_results.txt', 'w') as output_file:
    lines = [line.strip() for line in file.readlines() if line.strip()]  # Remove empty lines
    data = {}  # Dictionary to hold data for each sample

    # Process each line in the input file
    for line in lines:
        for column in columns:
            if column in line:
                value = line.split(': ')[-1].replace(',', '') if column != "Sample Name" else line.split(': ')[1]
                
                # Handling values with parentheses
                if '(' in value and ')' in value:
                    value = extract_numeric_value(value)
                    
                if column == "Sample Name":
                    sample_name = value
                    data[sample_name] = {key: "" for key in columns}

                data[sample_name][column] = value

    # Write table headers to the output file
    output_file.write("\t".join(columns) + "\n")

    # Write the data to the output file
    for sample in data.values():
        output_file.write("\t".join([sample[col] for col in columns]) + "\n")

