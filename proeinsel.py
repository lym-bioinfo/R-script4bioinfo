from collections import defaultdict

blast_file = "TPS14_vs_poaceae.blast"
output_fasta = "TPS14_hits_filtered.fasta"
protein_fasta = "all_poaceae_proteins.fasta"

from Bio import SeqIO
seq_dict = SeqIO.to_dict(SeqIO.parse(protein_fasta, "fasta"))

best_hits = defaultdict(list)

with open(blast_file) as f:
    for line in f:
        parts = line.strip().split("\t")
        subject = parts[1]
        identity = float(parts[2])
        aln_len = int(parts[3])
        evalue = float(parts[10])
        query_len = len(seq_dict[parts[0]].seq)

        coverage = aln_len / query_len
        try:
            species = "_".join(subject.split("_")[1:3])
        except:
            continue

        if identity >= 50 and coverage >= 0.6:
            best_hits[species].append((subject, identity, coverage, evalue))

selected_ids = set()
for species, hits in best_hits.items():
    hits_sorted = sorted(hits, key=lambda x: x[3]) 
    for h in hits_sorted[:2]:
        selected_ids.add(h[0])

with open(output_fasta, "w") as out:
    for seqid in selected_ids:
        if seqid in seq_dict:
            SeqIO.write(seq_dict[seqid], out, "fasta")
