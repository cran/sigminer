## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval=FALSE---------------------------------------------------------
#  install.packages("sigminer")

## ---- eval=FALSE---------------------------------------------------------
#  remotes::install_github("ShixiangWang/sigminer")

## ------------------------------------------------------------------------
library(sigminer)

## ------------------------------------------------------------------------
laml.maf <- system.file("extdata", "tcga_laml.maf.gz", package = "maftools")
laml <- read_maf(maf = laml.maf)

## ------------------------------------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg19, quietly = TRUE)

sig_pre <- sig_prepare(laml, ref_genome = "BSgenome.Hsapiens.UCSC.hg19", 
                      prefix = "chr", add = TRUE)

## ------------------------------------------------------------------------
library(NMF)

## ---- eval=FALSE---------------------------------------------------------
#  sig_est <- sig_estimate(sig_pre$nmf_matrix, range = 2:5, pConstant = 0.01)

## ---- eval=FALSE---------------------------------------------------------
#  sig_laml <- sig_extract(sig_pre$nmf_matrix, n_sig = 2, mode = "mutation", pConstant = 0.01)

## ---- fig.width=10, eval=FALSE-------------------------------------------
#  draw_sig_profile(sig_laml$nmfObj, mode = "mutation")

## ---- eval=FALSE---------------------------------------------------------
#  pheatmap::pheatmap(mat= sig_laml$coSineSimMat, cluster_rows = FALSE,
#                     main = "Cosine similarity against validated COSMIC signatures")

