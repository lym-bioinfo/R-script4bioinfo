library(Biostrings)

fasta_directory <- "XXX"

fasta_files <- list.files(fasta_directory, pattern = "\\.fasta$", full.names = TRUE)

all_sequences <- DNAStringSet()

for (file in fasta_files) {
  sequences <- readDNAStringSet(file)
  all_sequences <- c(all_sequences, sequences)
}

writeXStringSet(all_sequences, file = "combined.fasta")
