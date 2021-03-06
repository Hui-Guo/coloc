\name{coloc.abf}
\alias{coloc.abf}
\title{Fully Bayesian colocalisation analysis using Bayes Factors}
\usage{
  coloc.abf(dataset1, dataset2, MAF = NULL, p1 = 1e-04,
    p2 = 1e-04, p12 = 1e-05)
}
\arguments{
  \item{dataset1}{a list with the following elements
  \describe{

  \item{pvalues}{P-values for each SNP in dataset 1}

  \item{N}{Number of samples in dataset 1}

  \item{MAF}{minor allele frequency of the variants}

  \item{beta}{regression coefficient for each SNP from
  dataset 1}

  \item{varbeta}{variance of beta}

  \item{type}{the type of data in dataset 1 - either
  "quant" or "cc" to denote quantitative or case-control}

  \item{s}{the proportion of samples in dataset 1 that are
  cases (only relevant for case control samples)}

  \item{snp}{a character vector of snp ids, optional. If
  present, it will be used to merge dataset1 and dataset2.
  Otherwise, the function assumes dataset1 and dataset2
  contain results for the same SNPs in the same order.}

  }

  Some of these items may be missing, but you must give
  \code{type} and then either \code{pvalues}, \code{N} and
  \code{s} (if type="cc") or \code{beta} and
  \code{varbeta}.  If you use pvalues, then the function
  needs to know minor allele frequencies, and will either
  use the MAF given here or a global estimate of MAF
  supplied separately.}

  \item{dataset2}{as above, for dataset 2}

  \item{MAF}{Common minor allele frequency vector to be
  used for both dataset1 and dataset2}

  \item{p1}{prior probability a SNP is associated with
  trait 1, default 1e-4}

  \item{p2}{prior probability a SNP is associated with
  trait 2, default 1e-4}

  \item{p12}{prior probability a SNP is associated with
  both traits, default 1e-5}
}
\value{
  a list of two \code{data.frame}s: \itemize{ \item summary
  is a vector giving the number of SNPs analysed, and the
  posterior probabilities of H0 (no causal variant), H1
  (causal variant for trait 1 only), H2 (causal variant for
  trait 2 only), H3 (two distinct causal variants) and H4
  (one common causal variant) \item results is an annotated
  version of the input data containing log Approximate
  Bayes Factors and intermediate calculations, and the
  posterior probability SNP.PP.H4 of the SNP being causal
  for the shared signal }
}
\description{
  Bayesian colocalisation analysis
}
\details{
  This function calculates posterior probabilities of
  different causal variant configurations under the
  assumption of a single causal variant for each trait.

  If regression coefficients and variances are available,
  it calculates Bayes factors for association at each SNP.
  If only p values are available, it uses an approximation
  that depends on the SNP's MAF and ignores any uncertainty
  in imputation.  Regression coefficients should be used if
  available.
}
\author{
  Claudia Giambartolomei, Chris Wallace
}

