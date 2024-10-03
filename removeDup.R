t <- read.csv("xx.csv", header = T)

library(dplyr)

df_unique <- t %>%
  distinct(t[[1]], .keep_all = TRUE)

write.csv(df_unique, "unique_genes_annotation.csv", row.names = FALSE)
