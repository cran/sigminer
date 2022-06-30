## ---- echo = FALSE, message = FALSE---------------------------------------------------------------
library(markdown)
library(knitr)
knitr::opts_chunk$set(
    error = FALSE,
    tidy  = TRUE,
    message = FALSE,
    fig.align = "center",
    collapse = TRUE,
    comment = "#>")
options(width = 100)
options(rmarkdown.html_vignette.check_title = FALSE)

## ----message=TRUE---------------------------------------------------------------------------------
library(sigminer)
data("simulated_catalogs")
mat <- t(simulated_catalogs$set1)

mat[1:5, 1:5]

## ----eval=FALSE-----------------------------------------------------------------------------------
#  # Here I reduce the values for n_bootstrap and n_nmf_run
#  # for reducing the run time.
#  # In practice, you should keep default or increase the values
#  # for better estimation.
#  #
#  # The input data here is simulated from 10 mutational signatures
#  e1 <- bp_extract_signatures(
#    mat,
#    range = 8:12,
#    n_bootstrap = 5,
#    n_nmf_run = 10
#  )

## ----include=FALSE--------------------------------------------------------------------------------
e1 <- readRDS("e1.rds")

## ----message=TRUE, fig.width=4, fig.height=3------------------------------------------------------
bp_show_survey2(e1, highlight = 10)

## -------------------------------------------------------------------------------------------------
obj <- bp_get_sig_obj(e1, 10)

## ----fig.width=10, fig.height=8-------------------------------------------------------------------
show_sig_profile(obj, mode = "SBS", style = "cosmic")

## ----fig.width=8, fig.height=5--------------------------------------------------------------------
show_sig_exposure(obj, rm_space = TRUE)

## ----message=TRUE---------------------------------------------------------------------------------
sim <- get_sig_similarity(obj, sig_db = "SBS")

## ----fig.width=10, fig.height=6-------------------------------------------------------------------
if (require(pheatmap)) {
  pheatmap::pheatmap(sim$similarity)
}

