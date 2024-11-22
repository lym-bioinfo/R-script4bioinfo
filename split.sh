#!/bin/bash

# 输入的fasta文件
input_fasta="Pseudomonas_plasmids_847.fasta"

# 输出目录
output_dir="split_fasta"
mkdir -p "$output_dir"

awk -v output_dir="$output_dir" '
/^>/ {
    if (seq) {
        print seq > filename
    }
    header = substr($0, 2)  # 去掉 ">"
    filename_part = substr(header, 1, index(header, " ") - 1)
    if (!filename_part) filename_part = header
    gsub(/[^a-zA-Z0-9._-]/, "_", filename_part)  # 替换非法字符
    filename = output_dir "/" filename_part ".fasta"
    seq = ""
    next
}
{
    seq = seq $0
}
END {
    if (seq) {
        print seq > filename
    }
}' "$input_fasta"

echo "拆分完成，文件已保存至 $output_dir"
