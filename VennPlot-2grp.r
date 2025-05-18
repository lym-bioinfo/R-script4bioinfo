library(dplyr)
library(readr)
library(VennDiagram)

file1 <- "MYL DEG WTJA vs. OXJA.txt"
file2 <- "DPF DEG WTJA vs. KOJA.txt"

q_threshold <- 0.05      
log2FC_cutoff <- 0

deg1 <- read_tsv(file1)
deg2 <- read_tsv(file2)

deg1_sig <- deg1 %>%
  filter(qvalue <= q_threshold & logFC >= log2FC_cutoff) %>%
  pull(gene_id)

deg2_sig <- deg2 %>%
  filter(qvalue <= q_threshold & logFC >= log2FC_cutoff) %>%
  pull(gene_id)

venn_list <- list(
  WTvsMYLOX = deg1_sig,
  WTvsDPFKO = deg2_sig)

venn.plot <- venn.diagram(
  x = venn_list,
  filename = NULL,
  col = "black",
  fill = c("#E69F00", "#56B4E9"),
  alpha = 0.5,
  cex = 1,
  fontfamily = "sans",
  fontface = "bold",
  cat.col = c("black", "black"),
  cat.cex = 1,
  cat.fontfamily = "sans",
  margin = 0.05
)

pdf("DOWNDEG.pdf", width = 6, height = 6)
grid::grid.draw(venn.plot)
dev.off()

common_genes <- intersect(deg1_sig, deg2_sig)
common_genes_df <- data.frame(gene_id = common_genes)
write_csv(common_genes_df, "Common_UP_DEGs.csv")
