# 创建数据框
data <- data.frame(
  value <- c(106.038, 65.784, 17.947, 53.780, 172.517, 65.652, 59.375, 47.406, 39.523, 41.344, 
             78.016, 56.439, 4.848, 4.284, 4.703, 0.171, 0.098, 0.447, 13.909, 23.901, 27.926, 
             2.667, 2.167, 0.942, 0.819, 2.494, 4.175),
  group = c("Nip", "Nip", "Nip", "VC18", "VC18", "VC18", 
            "Nim", "Nim", "Nim", "Nim", "Nim", "Nim", 
            "MYL1-OX1", "MYL1-OX1", "MYL1-OX1", "MYL1-OX6", "MYL1-OX6", "MYL1-OX6", 
            "MYL1-OX7", "MYL1-OX7", "MYL1-OX7", "MYL1-OX9", "MYL1-OX9", "MYL1-OX9", 
            "MYL1-OX11", "MYL1-OX11", "MYL1-OX11")
)

# 执行一元方差分析
model <- aov(value ~ group, data = data)

# 查看方差分析结果
summary(model)

# 进行Tukey的事后比较
tukey_result <- TukeyHSD(model)
tukey_df <- as.data.frame(tukey_result$`group`)

# 进行字母分组
groups <- HSD.test(model, "group", group = TRUE)

# 查看字母分组结果
print(groups)
