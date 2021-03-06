\name{selfcut.psp}
\alias{selfcut.psp}
\title{Cut Line Segments Where They Intersect}
\description{
  Finds any crossing points between the line segments in a 
  line segment pattern, and cuts the segments into pieces
  at these crossing-points.
}
\usage{
selfcut.psp(A, \dots, eps)
}
\arguments{
  \item{A}{
    Line segment pattern (object of class \code{"psp"}).
  }
  \item{eps}{
    Optional. Smallest permissible length of the resulting
    line segments. There is a sensible default.
  }
  \item{\dots}{Ignored.}
}
\details{
  This function finds any crossing points between
  different line segments in the line segment pattern \code{A},
  and cuts the line segments into pieces at these intersection points.

  A crossing point occurs whenever one of the line segments in \code{A}
  intersects another line segment in \code{A}, at a nonzero
  angle of intersection.
}
\value{
  Another line segment pattern (object of class \code{"psp"})
  in the same window as \code{A} with the same kind of marks as
  \code{A}.

  The result also has an attribute \code{"camefrom"} indicating
  the provenance of each segment in the result.
  For example \code{camefrom[3]=2} means that the third segment in the
  result is a piece of the second segment of \code{A}.
}
\author{
\spatstatAuthors.
}
\seealso{
  \code{\link{selfcrossing.psp}}
}
\examples{
  X <- psp(runif(10), runif(10), runif(10), runif(10), window=owin())
  Y <- selfcut.psp(X)
  n <- nsegments(Y)
  plot(Y \%mark\% factor(sample(seq_len(n), n, replace=TRUE)))
}
\keyword{spatial}
\keyword{manip}
