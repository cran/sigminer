#' Handle Hypermutant Samples
#'
#' This can be used for SNV/INDEL count matrix. For copy number analysis,
#' please skip it.
#'
#' @inheritParams sig_auto_extract
#'
#' @return a `matrix`.
#' @references
#' Kim, Jaegil, et al. "Somatic ERCC2 mutations are associated with a distinct genomic signature in urothelial tumors."
#'  Nature genetics 48.6 (2016): 600.
#' @export
handle_hyper_mutation <- function(nmf_matrix) {
  x <- t(nmf_matrix)
  for (i in 1:100) {
    mutation <- colSums(x)
    q1 <- quantile(mutation, prob = 1 / 4)
    q3 <- quantile(mutation, prob = 3 / 4)
    sample.hyper <- colnames(x)[mutation > (median(mutation) + 1.5 * (q3 - q1))]
    if (length(sample.hyper) == 0) break
    nmf_matrix.hyper <- as.matrix(x[, (colnames(x) %in% sample.hyper)])
    colnames(nmf_matrix.hyper) <- sample.hyper
    nmf_matrix.nonhyper <- x[, !(colnames(x) %in% sample.hyper)]
    nmf_matrix.hyper1 <- apply(nmf_matrix.hyper, 2, function(x) x / 2)
    nmf_matrix.hyper2 <- nmf_matrix.hyper1
    colnames(nmf_matrix.hyper1) <- paste(colnames(nmf_matrix.hyper1), 1, sep = "_[hyper]_") # use [hyper] as hyper mutation flag
    colnames(nmf_matrix.hyper2) <- paste(colnames(nmf_matrix.hyper2), 2, sep = "_[hyper]_")
    x <- cbind(nmf_matrix.nonhyper, nmf_matrix.hyper1, nmf_matrix.hyper2)
  }
  return(t(x))
}

collapse_hyper_records <- function(mat) {
  # Hyper marks in column names
  hyper_index <- grepl("_\\[hyper\\]_", colnames(mat))
  if (sum(hyper_index) > 0) {
    H.hyper <- mat[, hyper_index, drop = FALSE]
    H.nonhyper <- mat[, !hyper_index, drop = FALSE]
    sample.hyper <- sapply(
      colnames(H.hyper),
      function(x) strsplit(x, "_\\[hyper\\]_")[[1]][[1]]
    )
    unique.hyper <- unique(sample.hyper)
    n.hyper <- length(unique.hyper)
    x.hyper <- array(0, dim = c(nrow(H.hyper), n.hyper))
    for (i in 1:n.hyper) {
      x.hyper[, i] <- rowSums(H.hyper[, sample.hyper %in% unique.hyper[i], drop = FALSE])
    }
    colnames(x.hyper) <- unique.hyper
    rownames(x.hyper) <- rownames(mat)
    mat <- cbind(H.nonhyper, x.hyper)
  }
  mat
}
