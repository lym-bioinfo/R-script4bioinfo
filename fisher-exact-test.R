library(tibble)
library(dplyr)
GO_df <- read.csv("00up-regulated_COG.csv", header = 1)
rownames(GO_df) <- GO_df$COG
GO_df <- GO_df %>%
  select(-COG) %>%
  add_column(A = GO_df$up.regulated) %>%
  add_column(B = GO_df$up.total - GO_df$up.regulated) %>%
  add_column(C = GO_df$chromosomeCOG) %>%
  add_column(D = GO_df$chromosome.total - GO_df$chromosomeCOG)

GO_df_for_test <- GO_df %>%
  select(A, B, C, D)

GO_df_for_test <- GO_df_for_test %>%
  add_column(AB = GO_df$A + GO_df$B) %>%
  add_column(CD = GO_df$C + GO_df$D) %>%
  add_column(AC = GO_df$A + GO_df$C) %>%
  add_column(N = 5652)

Fisher_Exact_Test <- function(row){
  test.mat <- rbind(c(row['A'], row['B']),
                    c(row['C'], row['D']))
  test.results <- fisher.test(test.mat, alternative = "greater")
  return(test.results$p.value)
}

fisher.exact.test <- apply(X = GO_df_for_test, MARGIN = 1, FUN = Fisher_Exact_Test)

fisher.exact.test.q <- p.adjust(p = fisher.exact.test,
                                method = 'BH')

out_up_GO <- cbind(GO_df_for_test, fisher.exact.test, fisher.exact.test.q) %>%
  select(A, AC, AB, N, fisher.exact.test, fisher.exact.test.q) %>%
  rename(gene.number.in.DEG = A, gene.number.in.genome = AC, all.gene.number.in.DEG = AB, total.number = N,
         p.value = fisher.exact.test, FDR = fisher.exact.test.q)
