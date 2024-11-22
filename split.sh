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
    # 设置新文件名，基于序列的头信息
    header = substr($0, 2)  # 去掉 ">"
    filename = output_dir "/" header ".fasta"
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
