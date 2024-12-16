library(ggplot2)

data <- read.csv("TPM.csv", header = T, row.names = 1)

batch_info <- c(rep("Batch1", 16), rep("Batch2", 12), rep("Batch3", 8), rep("Batch4", 8))

pca <- prcomp(t(data))
pca_df <- data.frame(PC1 = pca$x[, 1], PC2 = pca$x[, 2], Batch = batch_info)
ggplot(pca_df, aes(x = PC1, y = PC2, color = Batch)) +
  geom_point() + theme_minimal()
