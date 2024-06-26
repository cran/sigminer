% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sig_auto_extract.R
\name{sig_auto_extract}
\alias{sig_auto_extract}
\title{Extract Signatures through the Automatic Relevance Determination Technique}
\usage{
sig_auto_extract(
  nmf_matrix = NULL,
  result_prefix = "BayesNMF",
  destdir = tempdir(),
  method = c("L1W.L2H", "L1KL", "L2KL"),
  strategy = c("stable", "optimal", "ms"),
  ref_sigs = NULL,
  K0 = 25,
  nrun = 10,
  niter = 2e+05,
  tol = 1e-07,
  cores = 1,
  optimize = FALSE,
  skip = FALSE,
  recover = FALSE
)
}
\arguments{
\item{nmf_matrix}{a \code{matrix} used for NMF decomposition with rows indicate samples and columns indicate components.}

\item{result_prefix}{prefix for result data files.}

\item{destdir}{path to save data runs, default is \code{tempdir()}.}

\item{method}{default is "L1W.L2H", which uses an exponential prior for W and
a half-normal prior for H (This method is used by PCAWG project, see reference #3).
You can also use "L1KL" to set expoential priors for both W and H, and "L2KL" to
set half-normal priors for both W and H. The latter two methods are originally
implemented by SignatureAnalyzer software.}

\item{strategy}{the selection strategy for returned data. Set 'stable' for getting optimal
result from the most frequent K. Set 'optimal' for getting optimal result from all Ks.
Set 'ms' for getting result with maximum mean cosine similarity with provided reference
signatures. See \code{ref_sigs} option for details.
If you want select other solution, please check \link{get_bayesian_result}.}

\item{ref_sigs}{A Signature object or matrix or string for specifying
reference signatures, only used when \code{strategy = 'ms'}.
See \code{Signature} and \code{sig_db} options in \link{get_sig_similarity} for details.}

\item{K0}{number of initial signatures.}

\item{nrun}{number of independent simulations.}

\item{niter}{the maximum number of iterations.}

\item{tol}{tolerance for convergence.}

\item{cores}{number of cpu cores to run NMF.}

\item{optimize}{if \code{TRUE}, then refit the denovo signatures with QP method, see \link{sig_fit}.}

\item{skip}{if \code{TRUE}, it will skip running a previous stored result. This can be used to
extend run times, e.g. you try running 10 times firstly and then you want to extend it to
20 times.}

\item{recover}{if \code{TRUE}, try to recover result from previous runs based on input \code{result_prefix},
\code{destdir} and \code{nrun}. This is pretty useful for reproducing result. Please use \code{skip} if you want
to recover an unfinished job.}
}
\value{
a \code{list} with \code{Signature} class.
}
\description{
A bayesian variant of NMF algorithm to enable optimal inferences for the
number of signatures through the automatic relevance determination technique.
This functions delevers highly interpretable and sparse representations for
both signature profiles and attributions at a balance between data fitting and
model complexity (this method may introduce more signatures than expected,
especially for copy number signatures (thus \strong{I don't recommend you to use this feature
to extract copy number signatures})). See detail part and references for more.
}
\details{
There are three methods available in this function: "L1W.L2H", "L1KL" and "L2KL".
They use different priors for the bayesian variant of NMF algorithm
(see \code{method} parameter) written by reference #1 and implemented in
SignatureAnalyzer software
(reference #2).

I copied source code for the three methods from Broad Institute and supplementary
files of reference #3, and wrote this higher function. It is more friendly for users
to extract, visualize and analyze signatures by combining with other powerful functions
in \strong{sigminer} package. Besides, I implemented parallel computation to speed up
the calculation process and a similar input and output structure like \code{\link[=sig_extract]{sig_extract()}}.
}
\examples{
\donttest{
load(system.file("extdata", "toy_copynumber_tally_W.RData",
  package = "sigminer", mustWork = TRUE
))
res <- sig_auto_extract(cn_tally_W$nmf_matrix, result_prefix = "Test_copynumber", nrun = 1)
# At default, all run files are stored in tempdir()
dir(tempdir(), pattern = "Test_copynumber")

laml.maf <- system.file("extdata", "tcga_laml.maf.gz", package = "maftools")
laml <- read_maf(maf = laml.maf)
mt_tally <- sig_tally(
  laml,
  ref_genome = "BSgenome.Hsapiens.UCSC.hg19",
  use_syn = TRUE
)

x <- sig_auto_extract(mt_tally$nmf_matrix,
  strategy = "ms", nrun = 3, ref_sigs = "legacy"
)
x
}
}
\references{
Tan, Vincent YF, and Cédric Févotte. "Automatic relevance determination in nonnegative matrix factorization with the/spl beta/-divergence."
IEEE Transactions on Pattern Analysis and Machine Intelligence 35.7 (2012): 1592-1605.

Kim, Jaegil, et al. "Somatic ERCC2 mutations are associated with a distinct genomic signature in urothelial tumors."
Nature genetics 48.6 (2016): 600.

Alexandrov, Ludmil, et al. "The repertoire of mutational signatures in human cancer." BioRxiv (2018): 322859.
}
\seealso{
\link{sig_tally} for getting variation matrix,
\link{sig_extract} for extracting signatures using \strong{NMF} package, \link{sig_estimate} for
estimating signature number for \link{sig_extract}.
}
\author{
Shixiang Wang
}
