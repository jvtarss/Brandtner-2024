# carregar as bibliotecas necessárias
library(dplyr)
library(RColorBrewer)
library(pheatmap)

# definir os genes que queremos analisar
genes_of_interest <- c("CYP2C9", "VKORC1", "GGCX", "NFE2L2", "NRF1", "CYP3A4", "EPHX1", "GSTM1")

# definir os caminhos dos arquivos de dados
file_paths <- c("C:/Users/User/Downloads/SRR11821363.csv",
                "C:/Users/User/Downloads/SRR11821367.csv",
                "C:/Users/User/Downloads/SRR11821368.csv",
                "C:/Users/User/Downloads/SRR11821365.csv",
                "C:/Users/User/Downloads/SRR11821364.csv",
                "C:/Users/User/Downloads/SRR11821366.csv")

# função para processar cada arquivo e filtrar os genes que queremos
process_file <- function(file) {
  data <- read.csv(file, row.names = 1)
  filtered_data <- subset(data, rownames(data) %in% genes_of_interest)
  return(filtered_data)
}

# inicializar uma lista para guardar os resultados de cada arquivo
results_list <- list()

# processar todos os arquivos e guardar os resultados individualmente
for (file in file_paths) {
  results <- process_file(file)
  results_list[[basename(file)]] <- results
}

# combinar os dados filtrados em um único data frame
combined_data <- Reduce(function(x, y) {
  merged_data <- merge(x, y, by = "row.names", all = TRUE)
  rownames(merged_data) <- merged_data$Row.names
  merged_data <- merged_data[,-1]
  return(merged_data)
}, results_list)

# verificar se todas as colunas são numéricas
combined_data <- as.data.frame(lapply(combined_data, as.numeric))

# adicionar +1 às contagens
combined_data <- combined_data + 1

# normalizar os dados em log
log_normalized_data <- log2(combined_data)

# escalar os dados para a faixa de -1,5 a +1,5
scaled_data <- t(apply(log_normalized_data, 1, scale))
scaled_data <- pmax(pmin(scaled_data, 1.5), -1.5)

# definir os rótulos das colunas
col_labels <- c("SRR11821363 (48h)", "SRR11821364 (48h)", "SRR11821365 (48h)",
                "SRR11821366 (120h)", "SRR11821367 (120h)", "SRR11821368 (120h)")

# definir os rótulos das linhas (genes)
row_labels <- genes_of_interest

# gerar o heatmap com a paleta Spectral
palette <- brewer.pal(n = 11, name = "Spectral")
pheatmap(scaled_data, color = palette, cluster_rows = TRUE, cluster_cols = TRUE, 
         main = "Heatmap dos Genes Selecionados", fontsize_row = 10, fontsize_col = 10,
         labels_col = col_labels, labels_row = row_labels)
