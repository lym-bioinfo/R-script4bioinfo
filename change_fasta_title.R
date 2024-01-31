library(Biostrings)

fasta_file <- readDNAStringSet(".fasta", format="fasta") 
names_fasta <- names(fasta_file) 
changed_names <- gsub("^.*_contig_", "contig_", names_fasta) #specified
names(fasta_file) <- changed_names
writeXStringSet(fasta_file, "result.fasta")
