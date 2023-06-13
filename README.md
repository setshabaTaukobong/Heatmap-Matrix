# Heatmap-Matrix
A heatmap matrix script that generates a restructured dataframe from a variant calling output file for conditional formatting in Excel. This script is intended for use as a post-processing step after trimming, filtering and variant calling. To ensure reproducibility of results, we have provided a variant calling output file (Dataset-Amino-Acid-Mutations.csv) and a metadata file (SARS_COV_2_analysis_2.xlsx). We have also included the output matrix file (Hetmap of spike region.xlsx) after conditional formatting on Excel, in this repository. 

# Packages to install
* library(dplyr)
* library(stringr)
* library(tidyr)
* library(tidyverse)

# Dependensies
The heatmap matrix script is entirely written in R (V.4.2.0), but requires preprocessing before running the script by the following tools:
* BWA mem (https://github.com/lh3/bwa)
* iVar (https://github.com/andersen-lab/ivar)
* samtools (https://github.com/samtools/samtools)
* LoFreq (https://github.com/CSB5/lofreq)

# Instructions
After running the dependencies and producing the variant calling file, run the heatmap script on the variant calling file to produce the desired matrix for conditional formatting.
