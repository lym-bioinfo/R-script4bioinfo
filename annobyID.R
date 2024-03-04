data <- read.csv("Anno.csv", header = T)

merge_annotations <- function(x) {
  merged <- paste(x, collapse = "; ")
  return(merged)
}

aggregated_data <- aggregate(Annotation ~ Gene, data, FUN = merge_annotations)

print(aggregated_data)

write.csv(aggregated_data, "Anno-merged.csv")
