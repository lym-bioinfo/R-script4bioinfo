#!/bin/bash

# 输入的fasta文件
input_fasta="input.fasta"

# 目标输出文件夹
output_dir="split_fasta"
mkdir -p "$output_dir"

# 使用awk处理并拆分fasta文件
awk '/^>/ {
    if (seq) {
        # 将之前的序列保存到文件
        print seq > filename
    }
    # 提取头部第一个空格前的内容作为文件名
    header = substr($0, 2)  # 去掉 ">"
    filename_part = substr(header, 1, index(header, " ") - 1)
    if (!filename_part) filename_part = header  # 如果没有空格，使用完整头部
    filename = output_dir "/" filename_part ".fasta"
    seq = ""
    next
}
{
    seq = seq $0
}
END {
    # 保存最后一条序列
    if (seq) {
        print seq > filename
    }
}' "$input_fasta"

echo "拆分完成，文件已保存至 $output_dir"
