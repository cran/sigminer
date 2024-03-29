% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_shannon_diversity_index.R
\name{get_shannon_diversity_index}
\alias{get_shannon_diversity_index}
\title{Get Shannon Diversity Index for Signatures}
\usage{
get_shannon_diversity_index(rel_expo, cutoff = 0.001)
}
\arguments{
\item{rel_expo}{a \code{data.frame} with numeric columns indicating
\strong{relative} signature exposures for each sample. Typically
this data can be obtained from \code{\link[=get_sig_exposure]{get_sig_exposure()}}.}

\item{cutoff}{a relative exposure cutoff for filtering signatures,
default is \verb{0.1\%}.}
}
\value{
a \code{data.frame}
}
\description{
\deqn{H = - \sum_{i=1}^n{p_i ln(p_i)}}
where \code{n} is the number
of signatures identified in the signature with exposure > \code{cutoff},
and \code{pi} is the normalized exposure of the ith signature with
exposure > \code{cutoff}. Exposures of signatures were normalized to
sum to \code{1}.
}
\examples{
# Load mutational signature
load(system.file("extdata", "toy_mutational_signature.RData",
  package = "sigminer", mustWork = TRUE
))
# Get signature exposure
rel_expo <- get_sig_exposure(sig2, type = "relative")
rel_expo
diversity_index <- get_shannon_diversity_index(rel_expo)
diversity_index
}
\references{
Steele, Christopher D., et al. "Undifferentiated sarcomas develop through distinct evolutionary pathways." Cancer Cell 35.3 (2019): 441-456.
}
