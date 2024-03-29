% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_h_arrow.R
\name{add_h_arrow}
\alias{add_h_arrow}
\title{Add Horizontal Arrow with Text Label to a ggplot}
\usage{
add_h_arrow(
  p,
  x,
  y,
  label = "optimal number",
  space = 0.01,
  vjust = 0.3,
  seg_len = 0.1,
  arrow_len = unit(2, "mm"),
  arrow_type = c("closed", "open"),
  font_size = 5,
  font_family = c("serif", "sans", "mono"),
  font_face = c("plain", "bold", "italic")
)
}
\arguments{
\item{p}{a \code{ggplot}.}

\item{x}{position at x axis.}

\item{y}{position at y axis.}

\item{label}{text label.}

\item{space}{a small space between arrow and text.}

\item{vjust}{vertical adjustment, set to 0 to align with the bottom,
0.5 for the middle, and 1 (the default) for the top.}

\item{seg_len}{length of the arrow segment.}

\item{arrow_len}{length of the arrow.}

\item{arrow_type}{type of the arrow.}

\item{font_size}{font size.}

\item{font_family}{font family.}

\item{font_face}{font face.}
}
\value{
a \code{ggplot} object.
}
\description{
Add Horizontal Arrow with Text Label to a ggplot
}
