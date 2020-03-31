% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/show_cn_features.R
\name{show_cn_features}
\alias{show_cn_features}
\title{Show Copy Number Feature Distributions}
\usage{
show_cn_features(
  features,
  method = "Macintyre",
  rm_outlier = FALSE,
  ylab = NULL,
  log_segsize = TRUE,
  log_y = FALSE,
  return_plotlist = FALSE,
  base_size = 12,
  nrow = 2,
  align = "hv",
  ...
)
}
\arguments{
\item{features}{a feature \code{list} generate from \link{sig_tally} function.}

\item{method}{method for feature classfication, can be one of "Macintyre" ("M") and
"Wang" ("W").}

\item{rm_outlier}{default is \code{FALSE}, if \code{TRUE}, remove outliers. Only
works when method is "Wang" ("W").}

\item{ylab}{lab of y axis.}

\item{log_segsize}{default is \code{TRUE}, show \code{log10} based segsize, only
works for input from "Macintyre" ("M") method.}

\item{log_y}{logical, if \code{TRUE}, show \code{log10} based y axis, only
works for input from "Wang" ("W") method.}

\item{return_plotlist}{if \code{TRUE}, return a list of ggplot objects but a combined plot.}

\item{base_size}{overall font size.}

\item{nrow}{(optional) Number of rows in the plot grid.}

\item{align}{(optional) Specifies whether graphs in the grid should be horizontally ("h") or
vertically ("v") aligned. Options are "none" (default), "hv" (align in both directions), "h", and "v".}

\item{...}{other options pass to \code{\link[cowplot]{plot_grid}} function of \code{cowplot} package.}
}
\value{
a \code{ggplot} object
}
\description{
Show Copy Number Feature Distributions
}
\examples{
# Load copy number prepare object
load(system.file("extdata", "toy_copynumber_tally_M.RData",
  package = "sigminer", mustWork = TRUE
))
p <- show_cn_features(cn_tally_M$features)
p
}