\name{methods.funxy}
\alias{methods.funxy} %DoNotExport
\alias{contour.funxy}
\alias{persp.funxy}
\alias{plot.funxy}
\Rdversion{1.1}
\title{
  Methods for Spatial Functions
}
\description{
  Methods for objects of the class \code{"funxy"}.
}
\usage{
\method{contour}{funxy}(x, \dots)
\method{persp}{funxy}(x, \dots)
\method{plot}{funxy}(x, \dots)
}
\arguments{
  \item{x}{
    Object of class \code{"funxy"} representing a
    function of \eqn{x,y} coordinates.
  }
  \item{\dots}{
    Named arguments controlling the plot. See Details.
  }
}
\details{
  These are methods for the generic functions
  \code{\link{plot}},
  \code{\link{contour}}
  and \code{\link{persp}}
  for the class \code{"funxy"} of spatial functions.

  Objects of class \code{"funxy"} are created, for example,
  by the commands \code{\link{distfun}} and \code{\link{funxy}}.
  
  The \code{plot}, \code{contour} and \code{persp} methods first convert
  \code{x} to a pixel image object using \code{\link{as.im}},
  then display it using \code{\link{plot.im}}, \code{\link{contour.im}} or
  \code{\link{persp.im}}.

  Additional arguments \code{\dots} are either
  passed to \code{\link{as.im.function}} to
  control the spatial resolution of the pixel image, or passed to 
  \code{\link{contour.im}},
  \code{\link{persp.im}} or 
  \code{\link{plot.im}} to control the appearance of the plot.

  In particular the argument \code{W} specifies the spatial domain
  over which the function will be plotted. See the Examples.
}
\value{
  \code{NULL}.
}
\author{
  \spatstatAuthors.
}
\seealso{
  \code{\link{funxy}},
  \code{\link{distfun}},
  \code{\link{as.im}},
  \code{\link{plot.im}},
  \code{\link{persp.im}},
  \code{\link{contour.im}},
  \code{\link{spatstat.options}}
}
\examples{
   f <- distfun(letterR)
   contour(f)
   ## plot it on a larger region
   B <- owin(c(1,5), c(-1, 4))
   contour(f, W=B)
   persp(f, W=B, theta=40, phi=40, border=NA, shade=0.7)
}
\keyword{spatial}
\keyword{methods}
