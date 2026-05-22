res <- read.csv(
  "/home/torin/Genome-Analysis/analyses/06_rna_analysis/deseq2/deseq2_results_heat_vs_control.csv",
  row.names = 1
)

# Remove NA padj values
res <- res[!is.na(res$padj), ]

# Assign colors
res$color <- "grey"

res$color[
  res$padj < 0.05 &
  res$log2FoldChange > 1
] <- "red"

res$color[
  res$padj < 0.05 &
  res$log2FoldChange < -1
] <- "blue"

# Output file
pdf("/home/torin/Genome-Analysis/analyses/06_rna_analysis/deseq2/Volcano_plot.pdf")

plot(
  res$log2FoldChange,
  -log10(res$padj),
  col = res$color,
  pch = 20,
  xlab = "log2 Fold Change",
  ylab = "-log10 adjusted p-value",
  main = "Heat vs Control"
)

abline(v = c(-1,1), lty = 2)
abline(h = -log10(0.05), lty = 2)

legend(
  "topright",
  legend = c("Upregulated", "Downregulated", "Not significant"),
  col = c("red", "blue", "grey"),
  pch = 20
)

dev.off()
