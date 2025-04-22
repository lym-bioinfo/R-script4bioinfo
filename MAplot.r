library(DESeq2)
library(ggplot2)
count_data <- read.table("xxx", header = 1, row.names = 1)

colData <- data.frame(
  row.names = colnames(count_data),
  condition = factor(c("A", "A", "A", "B", "B", "B"))
)

dds <- DESeqDataSetFromMatrix(countData = count_data, colData = colData, design = ~ condition)

dds <- DESeq(dds)
res <- results(dds)

res_df <- as.data.frame(res)

res_df$regulation <- "Not Significant"
res_df$regulation[res_df$padj < 0.05 & res_df$log2FoldChange > 1] <- "Up"
res_df$regulation[res_df$padj < 0.05 & res_df$log2FoldChange < -1] <- "Down"

reg_colors <- c("Up" = "red", "Down" = "blue", "Not Significant" = "grey")

ggplot(res_df, aes(x = log10(baseMean + 1), y = log2FoldChange, color = regulation)) +
  geom_point(alpha = 0.6, size = 2) +
  scale_color_manual(values = reg_colors) +
  coord_cartesian(xlim = c(0, 7), ylim = c(-7.5, 7.5))+
  theme_minimal() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(title = "5a / oscoi2 vs mock / oscoi2", x = "log10(Base Mean)", y = "log2(Fold Change)", color = "Regulation")
