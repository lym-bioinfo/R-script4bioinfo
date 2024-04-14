library(Biostrings)

fastaFilePath <- "combined.fasta"
sequences <- readDNAStringSet(fastaFilePath)

pattern <- "CA[ATCG][ATCG]TG"

count <- 0
for (i in seq_along(sequences)) {
  seq <- as.character(sequences[i])
  if (length(grep(pattern, seq, ignore.case = TRUE)) > 0) {
    count <- count + 1
  }
}

print(count)
summary(sequences)
