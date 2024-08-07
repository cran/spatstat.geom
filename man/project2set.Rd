\name{project2set}
\alias{project2set}
\title{
  Find Nearest Point in a Region
}
\description{
  For each data point in a point pattern \code{X},
  find the nearest location in a given spatial region \code{W}.
}
\usage{
  project2set(X, W, \dots)
}
\arguments{
  \item{X}{
    Point pattern (object of class \code{"ppp"}).
  }
  \item{W}{
    Window (object of class \code{"owin"})
    or something acceptable to \code{\link{as.owin}}.
  }
  \item{\dots}{
    Arguments passed to \code{\link[spatstat.geom]{as.mask}} controlling the
    pixel resolution.
  }
}
\details{
  The window \code{W} is first discretised as a binary mask
  using \code{\link[spatstat.geom]{as.mask}}.
  
  For each data point \code{X[i]} in the point pattern \code{X},
  the algorithm finds the nearest pixel in \code{W}.

  The result is a point pattern \code{Y} containing these nearest points,
  that is, \code{Y[i]} is the nearest point in \code{W} to the
  point \code{X[i]}.
}
\value{
  A point pattern (object of class \code{"ppp"}) with the same
  number of points as \code{X} in the window \code{W}.
}
\author{\adrian
  
  
  \rolf
  
  and \ege
  
}
\seealso{
  \code{\link{project2segment}},
  \code{\link{nncross}}
}
\examples{
  He <- heather$fine[owin(c(2.8, 7.4), c(4.0, 7.8))]
  plot(He, main="project2set")
  W <- erosion(complement.owin(He), 0.2)
if(require(spatstat.random)) {
  X <- runifpoint(4, W)
} else {
  X <- ppp(c(6.1, 4.3, 5.7, 4.7), c(5.0, 6.6, 7.5, 4.9), window=W)
}
  points(X, col="red")
  Y <- project2set(X, He)
  points(Y, col="green")
  arrows(X$x, X$y, Y$x, Y$y, angle=15, length=0.2)
}
\keyword{spatial}
\keyword{math}

