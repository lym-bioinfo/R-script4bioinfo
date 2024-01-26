library(GenomicFeatures)
library(rtracklayer)
gff_file <- "locus.gff"
gene_annotation <- readGFF(gff_file)

target_gene_id <- "xx"  
target_gene <- gene_annotation[!is.na(gene_annotation$Name) & gene_annotation$Name == target_gene_id, ]

upstream_length <- 3000  # 3kb
if (target_gene$strand == "+") {
  upstream_start <- target_gene$start - upstream_length
  upstream_end <- target_gene$start - 1
} else if (target_gene$strand == "-") {
  upstream_start <- target_gene$end + 1
  upstream_end <- target_gene$end + upstream_length
}

library(Biostrings)
library(BSgenome)
genome_fasta_file <- "24.fasta"  
genome_seq <- readDNAStringSet(genome_fasta_file)
chromosome_name <- "chr0x"
upstream_sequence <- substring(genome_seq[chromosome_name], upstream_start, upstream_end)
upstream_sequence <- DNAStringSet(c(upstream_sequence))

if (target_gene$strand == "-") {
  upstream_sequence <- reverseComplement(upstream_sequence)
}

library(seqinr)
output_fasta_file <- paste(target_gene_id, ".fasta", sep = "")
write.fasta(sequences = upstream_sequence, names = target_gene_id, file.out = output_fasta_file)

