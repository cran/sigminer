% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simulation.R
\name{simulation}
\alias{simulation}
\alias{simulate_signature}
\alias{simulate_catalogue}
\alias{simulate_catalogue_matrix}
\title{Simulation Analysis}
\usage{
simulate_signature(x, weights = NULL)

simulate_catalogue(x, n, weights = NULL)

simulate_catalogue_matrix(x)
}
\arguments{
\item{x}{a numeric vector representing a signature/catalog or matrix with rows representing
signatures/samples and columns representing components.}

\item{weights}{a numeric vector for weights.}

\item{n}{an integer indicating mutation number to be generated in a catalog.}
}
\value{
a \code{matrix}.
}
\description{
\itemize{
\item \code{simulate_signature()} - Simulate signatures from signature pool.
\item \code{simulate_catalogue()} - Simulate catalogs from signature/catalog pool.
\item \code{simulate_catalogue_matrix()} - Simulate a bootstrapped catalog matrix.
}
}
\examples{
# Generate a catalog
set.seed(1234)
catalog <- as.integer(table(sample(1:96, 1000, replace = TRUE)))
names(catalog) <- paste0("comp", 1:96)
# Generate a signature
sig <- catalog / sum(catalog)

# Simulate catalogs
x1 <- simulate_catalogue(catalog, 10) # 10 mutations
x1
x2 <- simulate_catalogue(catalog, 100) # 100 mutations
x2
x3 <- simulate_catalogue(catalog, 1000) # 1000 mutations
x3
# Similar with a signature
x4 <- simulate_catalogue(sig, 10) # 10 mutations
x4

# Load SBS signature
load(system.file("extdata", "toy_mutational_signature.RData",
  package = "sigminer", mustWork = TRUE
))
s <- t(sig2$Signature.norm)
# Generate a signature from multiple signatures/catalogs
s1 <- simulate_signature(s)
s1
s2 <- simulate_signature(s, weights = 1:3)
s2
# Generate a catalog from multiple signatures/catalogs
c1 <- simulate_catalogue(s, 100, weights = 1:3)
c1
}
