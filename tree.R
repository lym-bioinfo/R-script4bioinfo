library(ggtree)
library(treeio)
library(ape)
library(ggplot2)
tree <- read.tree("Newick Export.nwk")

p <- ggtree(tree, layout = "circular", branch.length = "none") +
  geom_tiplab(size = 4, fontface = "italic", hjust = -0.1) +  
  geom_text2(aes(label = label), hjust = -0.2, 
             subset = !isTip & as.numeric(label) > 50) +  
  theme_void()

print(p)

