####################################################Heatmap matrix script#######################################################
###Version of R used 4.2.0
library(dplyr)
library(stringr)
library(tidyr)
library(tidyverse)
library("writexl")
##Import dataset

library(readr)
Dataset_Amino_Acid_Mutations <- read_delim("path/Dataset_Amino_Acid_Mutations.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)
View(Dataset_Amino_Acid_Mutations)

###Remove columns that are not needed
dfa = subset(Dataset_Amino_Acid_Mutations, select = -c(POS ,REF ,ALT, DP, SB, DP4, IMPACT, FUNCLASS, EFFECT, GENE, CODON, TRID, change, min, max, CH, FC) )
###Remove last part of sample name
Dataset_Amino_Acid_Mutations$Sample <- gsub("_S.*", "", Dataset_Amino_Acid_Mutations$Sample)
###Using the variant calling output, create 3 columns thats seperates amino acid mutations in column AA with format A701V into Wildtype (A), position (701) and mutant (V).
dfa$Wildtype <- str_extract(dfa$AA, "^\\D+")
dfb <- dfa %>% mutate(position = as.numeric(str_extract(AA, "[0-9]+")))
dfb$Mutant <- str_sub(dfb$AA, -1, -1)
###Ceate a matrix comprising of sample IDs as rows, position of mutation as columns (1-1273 for spike region of SARS-CoV-2) and the mutations read frequency (column AF) within the matrix in their respective positions
dfc <- dfb %>%
  select(Sample, position, Mutant, AF) %>%
  pivot_wider(names_from = position, values_from = AF)
### Rename columns
original_cols <- colnames(dfc)
colnames(dfc) <- paste("p" ,original_cols,sep="")
# Order columns numerically
dfd <- dfc %>% select(pSample, num_range("p", range = 1:1273))
###Merge cells with same row name into one
dfe <- dfd %>%
  group_by(pSample) %>%
  summarise_all(funs(toString(na.omit(.))))
###Merge current dataset with metadata by sample ID
dff <- merge(dfe, SARS_COV_2_analysis_2, by = "pSample")
###Save as excel file file
write_xlsx(dff, 'path/Spike_mutational_read_Frequency_dataset.xlsx')
