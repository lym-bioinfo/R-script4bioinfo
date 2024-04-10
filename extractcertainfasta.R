library(Biostrings)
library(seqinr)
fasta_sequences <- readDNAStringSet("xx.fasta")
genes_to_extract <- c("gene name")
extracted_sequences <- list()
for (gene in genes_to_extract) {
  pattern <- paste0("^gene:", gene, "\\b") 
  matches <- sapply(names(fasta_sequences), function(x) grepl(pattern, x))
  extracted_sequences[[gene]] <- fasta_sequences[matches]
  writeXStringSet(extracted_sequences[[gene]], file=paste0(gene, ".fasta"))
}
