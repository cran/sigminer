#' Get Signature Exposure from 'Signature' Object
#'
#' The expected number of mutations (or copy number segment records) with each signature was
#' determined after a scaling transformation V ~ WH = W'H' where W' = WU' and H' = UH.
#' The scaling matrix U is a KxK diagnal matrix (K is signature number, U' is the inverse of U)
#' with the element corresponding to the L1-norm of column vectors of W
#' (ie. the sum of the elements of the vector). As a result, the k-th row vector of the final
#' matrix H' represents the absolute exposure (activity) of the k-th process across samples
#' (e.g., for SBS, the estimated (or expected) number of mutations generated by the k-th process).
#' Of note, for copy number signatures, only components of feature CN was used for calculating H'.
#'
#' @param Signature a `Signature` object obtained either from [sig_extract] or [sig_auto_extract],
#' or just a raw exposure matrix with column representing samples (patients) and row
#' representing signatures.
#' @param type 'absolute' for signature exposure and 'relative' for signature relative exposure.
#' @param rel_threshold only used when type is 'relative', relative exposure less
#' than (`<=`) this value will be set to 0 and thus all signature exposures
#' may not sum to 1. This is similar to this argument in [sig_fit].
#' @return a `data.table`
#' @references
#' Kim, Jaegil, et al. "Somatic ERCC2 mutations are associated with a distinct genomic signature in urothelial tumors."
#'  Nature genetics 48.6 (2016): 600.
#' @author Shixiang Wang <w_shixiang@163.com>
#' @export
#'
#' @examples
#' # Load mutational signature
#' load(system.file("extdata", "toy_mutational_signature.RData",
#'   package = "sigminer", mustWork = TRUE
#' ))
#' # Get signature exposure
#' expo1 <- get_sig_exposure(sig2)
#' expo1
#' expo2 <- get_sig_exposure(sig2, type = "relative")
#' expo2
#' @testexamples
#' expect_equal(nrow(expo1), 188L)
#' expect_equal(nrow(expo2), 186L)
get_sig_exposure <- function(Signature,
                             type = c("absolute", "relative"),
                             rel_threshold = 0.01) {
  if (inherits(Signature, "Signature")) {
    h <- Signature$Exposure
  } else if (is.matrix(Signature)) {
    if (!all(startsWith(rownames(Signature), "Sig"))) {
      stop("If Signature is a matrix, row names must start with 'Sig'!", call. = FALSE)
    }
    h <- Signature
  } else {
    stop("Invalid input for 'Signature'", call. = FALSE)
  }

  if (is.null(rownames(h)) | is.null(colnames(h))) {
    stop("Rownames or Colnames cannot be NULL!")
  }

  type <- match.arg(type)

  h <- t(h) %>%
    as.data.frame() %>%
    tibble::rownames_to_column(var = "sample") %>%
    data.table::as.data.table()
  if (type == "absolute") {
    return(h)
  }
  h_norm <- h[, -1] / rowSums(h[, -1])
  h_norm[h_norm <= rel_threshold] <- 0
  h_norm <- na.omit(cbind(h[, 1], h_norm))
  return(h_norm)
}
