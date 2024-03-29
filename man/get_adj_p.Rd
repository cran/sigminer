% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_adj_p.R
\name{get_adj_p}
\alias{get_adj_p}
\title{Get Adjust P Values from Group Comparison}
\source{
https://github.com/kassambara/ggpubr/issues/143
}
\usage{
get_adj_p(
  data,
  .col,
  .grp = "Sample",
  comparisons = NULL,
  method = "wilcox.test",
  p.adjust.method = "fdr",
  p.digits = 3L,
  ...
)
}
\arguments{
\item{data}{a \code{data.frame} containing column for groups and column for comparison.}

\item{.col}{column name for comparison.}

\item{.grp}{column name for groups.}

\item{comparisons}{Default is \code{NULL}, use all combination in group column.
It can be a list of length-2 vectors. The entries in the vector are either
the names of 2 values on the x-axis or the 2 integers that correspond to the
index of the groups of interest, to be compared.}

\item{method}{a character string indicating which method to be used for comparing means.
It can be 't.test', 'wilcox.test' etc..}

\item{p.adjust.method}{correction method, default is 'fdr'. Run \code{p.adjust.methods} to
see all available options.}

\item{p.digits}{how many significant digits are to be used.}

\item{...}{other arguments passed to \code{\link[ggpubr:compare_means]{ggpubr::compare_means()}}}
}
\value{
a \code{data.frame} containing comparison result
}
\description{
Setting \code{aes(label=..p.adj..)} in \code{\link[ggpubr:compare_means]{ggpubr::compare_means()}} does not
show adjust p values. The returned result of this function can be combined with \code{\link[ggpubr:stat_pvalue_manual]{ggpubr::stat_pvalue_manual()}} to fix
this problem.
}
\details{
More info see \code{\link[ggpubr:compare_means]{ggpubr::compare_means()}}, \code{\link[ggpubr:stat_compare_means]{ggpubr::stat_compare_means()}} and \code{\link[stats:p.adjust]{stats::p.adjust()}}.
}
\examples{
library(ggpubr)
# T-test
stat.test <- compare_means(
  len ~ dose,
  data = ToothGrowth,
  method = "t.test",
  p.adjust.method = "fdr"
)
stat.test
# Create a simple box plot
p <- ggboxplot(ToothGrowth, x = "dose", y = "len")
p

# Add p values
my_comparisons <- list(c("0.5", "1"), c("1", "2"), c("0.5", "2"))
p + stat_compare_means(method = "t.test", comparisons = my_comparisons)

# Try adding adjust p values
# proposed by author of ggpubr
# however it does not work
p + stat_compare_means(aes(label = ..p.adj..), method = "t.test", comparisons = my_comparisons)

# Solution:
# calculate adjust p values and their location
# then use stat_pvalue_manual() function
p_adj <- get_adj_p(ToothGrowth, .col = "len", .grp = "dose")
p_adj
p + stat_pvalue_manual(p_adj, label = "p.adj")

# Show selected comparisons
# Of note, p value is ajusted
# for three comparisons, but only
# two are showed in figure
p_adj <- get_adj_p(ToothGrowth,
  .col = "len", .grp = "dose",
  comparisons = list(c("0.5", "1"), c("1", "2"))
)
p + stat_pvalue_manual(p_adj, label = "p.adj")
}
