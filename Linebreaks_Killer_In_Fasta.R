input_file <- "A23.fasta" 
output_file <- "A23output.fasta"

lines <- readLines(input_file)

processed_fasta <- list()

i <- 1
while (i <= length(lines)) {
  line <- lines[i]
  
  if (startsWith(line, ">")) {
    header <- line
    sequence <- ""
    i <- i + 1
    
    while (i <= length(lines) && !startsWith(lines[i], ">")) {
      sequence <- paste0(sequence, lines[i])
      i <- i + 1
    }

    
    processed_fasta <- append(processed_fasta, header)
    processed_fasta <- append(processed_fasta, sequence)
    
  } else {
    i <- i + 1
  }
}

writeLines(unlist(processed_fasta), output_file)

cat(paste("finished", output_file, "\n"))
