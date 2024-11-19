
# Carica i pacchetti necessari
library(ggplot2)
library(dplyr)

# Leggi il file CSV
dati <- read.csv("D:/Desktop/progetti_v1/15_RNA_SEQ_IBS_FATIMA/08_rsiposte_revisori/Figure_/dotplot_reactome_/reactome_54_genes.csv", sep = ";")

# Ordina i dati in base a Curated_Total in ordine decrescente
dati <- dati %>%
  arrange(desc(Curated_Total))

# Crea il grafico
ggplot(dati, aes(x = Curated_Total, y = reorder(Pathway_name, Curated_Total), color = Curated_found, size = Curated_Total)) +
  geom_point(alpha = 0.6) +  # Aggiungi trasparenza per migliorare la leggibilità
  scale_color_gradient(low = "blue", high = "red") +  # Gradiente di colori dal blu al rosso
  scale_size(range = c(1, 10)) +  # Regola la gamma di dimensioni dei cerchi
  labs(x = 'Curated Total', y = 'Pathway Name', color = 'Curated Found', size = 'Curated Total\nSize') +  # Etichette
  theme(axis.title = element_text(face = 'bold'), axis.text = element_text(face = 'bold'))  # Tema personalizzato
