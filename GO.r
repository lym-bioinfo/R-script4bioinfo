library(ggplot2)
library(dplyr)

df <- read.csv("down.csv")
df <- df %>%
  mutate(logFDR = -log10(FDR))

ggplot(df, aes(
  x = FoldEnrichment,
  y = reorder(Pathway, FoldEnrichment),  
  color = logFDR,        
  shape = Type,          
  size = Number          
)) +
  geom_point() +
  scale_color_gradient(low = "#6699CC", high = "red") +
  scale_size_continuous(range = c(2, 5)) +
  labs(
    x = "Fold Enrichment",
    y = "Pathway",
    color = "-log10(FDR)",
    shape = "Type",
    size = "Gene Number"
  ) +
  theme_bw(base_size = 12) +
  theme(
    axis.title = element_text(size = 16, color = "black"),
    axis.text = element_text(size = 12, color = "black"),
    legend.title = element_text(size = 12, color = "black"),
    legend.text = element_text(size = 12, color = "black"),
    axis.text.x = element_text(size = 16, color = "black")
  ) +
  guides(
    color = guide_legend(override.aes = list(size = 5)),
    shape = guide_legend(override.aes = list(size = 5))
  )
