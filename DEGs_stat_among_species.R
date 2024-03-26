library(ggplot2)

data <- data.frame(
  Category = c("Or", "Or", "Or", "Or", "Or", "Or",
               "Op", "Op", "Op", "Op", "Op", "Op",
               "Oo", "Oo", "Oo", "Oo", "Oo", "Oo",
               "Ob", "Ob", "Ob", "Ob", "Ob", "Ob",
               "Lp", "Lp", "Lp", "Lp", "Lp", "Lp"),
  Subcategory = c("8up", "4up8", "1up4", "1do4", "4do8", "8do",
                  "8up", "4up8", "1up4", "1do4", "4do8", "8do",
                  "8up", "4up8", "1up4", "1do4", "4do8", "8do",
                  "8up", "4up8", "1up4", "1do4", "4do8", "8do",
                  "8up", "4up8", "1up4", "1do4", "4do8", "8do"),
  Value = c(52, 213, 317, 132, 90, 18,
            71, 357, 183, 32, 40, 1,
            101, 295, 0, 0, 273, 69,
            7, 78, 100, 261,101, 5,
            69, 278, 147, 36, 42, 8)
)

data$Subcategory <- factor(data$Subcategory, levels = c("8up", "4up8", "1up4", "1do4", "4do8", "8do"))
data$Category <- factor(data$Category, levels = c("Or", "Op", "Oo", "Ob", "Lp"))

ggplot(data, aes(x = Category, y = Value, fill = Subcategory)) +
  geom_bar(stat = "identity", position = "stack", width = 0.3) +
  scale_fill_brewer(palette = "Spectral") +
  theme_classic() +
  scale_y_continuous(breaks = seq(0, 1000, by = 200), limits = c(0, 1000)) +
  labs(title = "legend", x = "xx", y = "yy")
