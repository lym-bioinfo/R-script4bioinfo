fasta_file <- "combined.fasta"
dna_sequences <- readDNAStringSet(fasta_file)

pattern <- "CACGAG"
reverse_complement_pattern <- reverseComplement(DNAString(pattern))

matches <- lapply(seq_along(dna_sequences), function(i) {
  sequence <- as.character(dna_sequences[i])
  forward_matches <- matchPattern(pattern, sequence)
  reverse_matches <- matchPattern(reverse_complement_pattern, sequence)
  list(forward=as.data.frame(forward_matches), reverse=as.data.frame(reverse_matches))
})

sequence_names <- names(dna_sequences)
for (i in seq_along(matches)) {
  cat("Sequence Name:", sequence_names[i], "\n")
  cat("Sequence Index:", i, "matches:\n")
  cat("Forward matches:\n")
  print(matches[[i]]$forward)
  cat("Reverse matches:\n")
  print(matches[[i]]$reverse)
  cat("\n")
}

