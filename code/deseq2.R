# DESeq2 differential expression analysis

library(DESeq2)

# Paths
count_file <- "/home/torin/Genome-Analysis/analyses/06_rna_analysis/counts/gene_counts_all_samples.txt"
outdir <- "/home/torin/Genome-Analysis/analyses/06_rna_analysis/deseq2"

# Read featureCounts output
counts_raw <- read.delim(count_file, comment.char = "#", check.names = FALSE)

# Extract count columns
count_data <- counts_raw[, 7:ncol(counts_raw)]
rownames(count_data) <- counts_raw$Geneid

# Rename samples
colnames(count_data) <- c(
  "Control_1",
  "Control_2",
  "Control_3",
  "Heat_1",
  "Heat_2",
  "Heat_3"
)

# Sample metadata
sample_info <- data.frame(
  row.names = colnames(count_data),
  condition = factor(c("Control", "Control", "Control", "Heat", "Heat", "Heat"))
)

# Create DESeq2 object
dds <- DESeqDataSetFromMatrix(
  countData = count_data,
  colData = sample_info,
  design = ~ condition
)

# Filter low-count genes
dds <- dds[rowSums(counts(dds)) >= 10, ]

# Run DESeq2
dds <- DESeq(dds)

# Results: Heat vs Control
res <- results(dds, contrast = c("condition", "Heat", "Control"))
res <- res[order(res$padj), ]

# Save results
write.csv(as.data.frame(res),
          file = file.path(outdir, "deseq2_results_heat_vs_control.csv"))

# Save normalized counts
norm_counts <- counts(dds, normalized = TRUE)
write.csv(as.data.frame(norm_counts),
          file = file.path(outdir, "normalized_counts.csv"))

# Summary
sink(file.path(outdir, "deseq2_summary.txt"))
summary(res)
cat("\nNumber of genes with padj < 0.05:\n")
print(sum(res$padj < 0.05, na.rm = TRUE))
cat("\nNumber of upregulated genes, padj < 0.05 and log2FC > 1:\n")
print(sum(res$padj < 0.05 & res$log2FoldChange > 1, na.rm = TRUE))
cat("\nNumber of downregulated genes, padj < 0.05 and log2FC < -1:\n")
print(sum(res$padj < 0.05 & res$log2FoldChange < -1, na.rm = TRUE))
sink()

# Basic plots
pdf(file.path(outdir, "MA_plot.pdf"))
plotMA(res, ylim = c(-5, 5))
dev.off()

# PCA plot
vsd <- vst(dds, blind = FALSE)

pdf(file.path(outdir, "PCA_plot.pdf"))
plotPCA(vsd, intgroup = "condition")
dev.off()
