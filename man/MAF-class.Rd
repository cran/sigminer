% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class.R
\docType{class}
\name{MAF-class}
\alias{MAF-class}
\alias{MAF}
\title{Class MAF}
\description{
S4 class for storing summarized MAF. It is from \code{maftools} package.
}
\details{
More about MAF object please see \href{https://github.com/PoisonAlien/maftools}{maftools}.
}
\section{Slots}{

\describe{
\item{\code{data}}{data.table of MAF file containing all non-synonymous variants.}

\item{\code{variants.per.sample}}{table containing variants per sample}

\item{\code{variant.type.summary}}{table containing variant types per sample}

\item{\code{variant.classification.summary}}{table containing variant classification per sample}

\item{\code{gene.summary}}{table containing variant classification per gene}

\item{\code{summary}}{table with basic MAF summary stats}

\item{\code{maf.silent}}{subset of main MAF containing only silent variants}

\item{\code{clinical.data}}{clinical data associated with each sample/Tumor_Sample_Barcode in MAF.}
}}

