\name{compatible}
\alias{compatible}
\title{Test Whether Objects Are Compatible}
\description{
  Tests whether two or more objects of the same class 
  are compatible.
}
\usage{
  compatible(A, B, \dots)
}
\arguments{
  \item{A,B,\dots}{Two or more objects of the same class}
}
\details{
  This generic function is used to check whether the
  objects \code{A} and \code{B} (and any additional
  objects \code{\dots}) are compatible.

  What is meant by \sQuote{compatible} depends on the class of object.

  There are methods for the classes \code{"fv"}, \code{"fasp"},
  \code{"im"} and \code{"unitname"}. See the documentation for these
  methods for further information.
}
\value{
  Logical value: \code{TRUE} if the objects are compatible, and \code{FALSE}
  if they are not.
}
\seealso{
  \code{\link[spatstat.explore]{compatible.fv}},
  \code{\link[spatstat.explore]{compatible.fasp}},
  \code{\link{compatible.im}},
  \code{\link{compatible.unitname}} 
}
\author{
  \spatstatAuthors.
}
\keyword{spatial}
\keyword{manip}
