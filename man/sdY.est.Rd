\name{sdY.est}
\alias{sdY.est}
\title{Estimate trait variance, internal function}
\usage{
  sdY.est(vbeta, maf, n)
}
\arguments{
  \item{vbeta}{vector of variance of coefficients}

  \item{maf}{vector of MAF (same length as vbeta)}

  \item{n}{sample size}
}
\value{
  estimated standard deviation of Y
}
\description{
  Estimate trait standard deviation given vectors of
  variance of coefficients, MAF and sample size
}
\details{
  Estimate is based on var(beta-hat) = var(Y) / (n *
  var(X)) var(X) = 2*maf*(1-maf) so we can estimate var(Y)
  by regressing n*var(X) against 1/var(beta)
}
\author{
  Chris Wallace
}

