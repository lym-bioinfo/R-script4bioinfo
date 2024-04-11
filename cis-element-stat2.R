library(Biostrings)

fastaFilePath <- "combined.fasta"  
sequences <- readDNAStringSet(fastaFilePath)

if (length(sequences) == 0) {
  stop("No sequences found in the file. Please check the file path and content.")
}

count <- 0
# || countPattern("CTCGTG", seq) > 0
for (i in seq_along(sequences)) {
  seq <- as.character(sequences[i])
  if (countPattern("CACGAG", seq) > 0 || countPattern("CTCGTG", seq) > 0) {
    count <- count + 1
  }
}

print(count)
summary(sequences)
