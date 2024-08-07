
# Assicurati che ggplot2 sia caricato
library(ggplot2)


# Sostituisci "path/to/your/file.csv" con il percorso reale del tuo file CSV
dati <- read.csv("D:/Desktop/progetti_v1/15_RNA_SEQ_IBS_FATIMA/08_rsiposte_revisori/Figure_/dotplot_reactome_/reactome_54_genes.csv", sep = ";")

# Verifica che i dati siano stati letti correttamente
class(dati)


ggplot(dati, aes(x = Curated_Total, y = Pathway_name, color = Curated_found, size = Curated_Total)) +
  geom_point(alpha = 0.6) + # Aggiungi trasparenza per migliorare la leggibilità
  scale_color_gradient(low = "blue", high = "red") + # Usa un gradiente di colori dal blu al rosso
  scale_size(range = c(1, 10)) + # Regola la gamma di dimensioni dei cerchi
  labs(x = 'Curated Total', y = 'Pathway Name', color = 'Curated Found', size = 'Curated Total\nSize') + # Aggiorna le etichette
  theme(axis.title = element_text(face = 'bold'), axis.text = element_text(face = 'bold')) # Modifica il tema



