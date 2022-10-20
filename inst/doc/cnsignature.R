## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(sigminer)

## -----------------------------------------------------------------------------
load(system.file("extdata", "toy_segTab.RData",
  package = "sigminer", mustWork = TRUE
))

set.seed(1234)
segTabs$minor_cn <- sample(c(0, 1), size = nrow(segTabs), replace = TRUE)
cn <- read_copynumber(segTabs,
  seg_cols = c("chromosome", "start", "end", "segVal"),
  genome_measure = "wg", complement = TRUE, add_loh = TRUE
)

## -----------------------------------------------------------------------------
cn
cn@data

## -----------------------------------------------------------------------------
tally_s <- sig_tally(cn, method = "S")

str(tally_s$all_matrices, max.level = 1)

## -----------------------------------------------------------------------------
sig_denovo = sig_auto_extract(tally_s$all_matrices$CN_48)
head(sig_denovo$Signature)

## -----------------------------------------------------------------------------
act_refit = sig_fit(t(tally_s$all_matrices$CN_48), sig_index = "ALL", sig_db = "CNS_TCGA")

## -----------------------------------------------------------------------------
act_refit2 = act_refit[apply(act_refit, 1, function(x) sum(x) > 0.1),]

rownames(act_refit2)

## ---- fig.width=10, fig.height=3----------------------------------------------
show_sig_profile(sig_denovo, mode = "copynumber", method = "S", style = "cosmic")

## -----------------------------------------------------------------------------
show_sig_exposure(sig_denovo)

## ---- fig.height=8, fig.width=10----------------------------------------------
show_sig_profile(
  get_sig_db("CNS_TCGA")$db[, rownames(act_refit2)],
  style = "cosmic", 
  mode = "copynumber", method = "S", check_sig_names = FALSE)

## -----------------------------------------------------------------------------
show_sig_exposure(act_refit2)

## -----------------------------------------------------------------------------
get_sig_similarity(sig_denovo, sig_db = "CNS_TCGA")

