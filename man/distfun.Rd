\name{distfun}  
\Rdversion{1.1}
\alias{distfun}
\alias{distfun.ppp}
\alias{distfun.psp}
\alias{distfun.owin}
\title{
  Distance Map as a Function 
}
\description{
  Compute the distance function of an object, and return it as a function.
}
\usage{
  distfun(X, \dots)

  \method{distfun}{ppp}(X, \dots, k=1, undef=Inf)

  \method{distfun}{psp}(X, \dots)

  \method{distfun}{owin}(X, \dots, invert=FALSE)
}
\arguments{
  \item{X}{Any suitable dataset representing a two-dimensional
    object, such as a point pattern (object of class \code{"ppp"}),
    a window (object of class \code{"owin"}) or a
    line segment pattern (object of class \code{"psp"}).
  }
  \item{\dots}{
    Extra arguments are ignored. 
  }
  \item{k}{
    An integer. The distance to the \code{k}th nearest point
    will be computed.
  }
  \item{undef}{
    The value that should be returned if the distance is undefined
    (that is, if \code{X} contains fewer than \code{k} points).
  }
  \item{invert}{
    If \code{TRUE}, compute the distance transform of the
    complement of \code{X}.
  }
}
\details{
  The \dQuote{distance function} of a set of points \eqn{A} is the
  mathematical function \eqn{f} such that, for any 
  two-dimensional spatial location \eqn{(x,y)},
  the function value \code{f(x,y)}
  is the shortest distance from \eqn{(x,y)} to \eqn{A}.

  The command \code{f <- distfun(X)} returns a \emph{function}
  in the \R language, with arguments \code{x,y}, that represents the
  distance function of \code{X}. Evaluating the function \code{f}
  in the form \code{v <- f(x,y)}, where \code{x} and \code{y}
  are any numeric vectors of equal length containing coordinates of
  spatial locations, yields the values of the distance function at these
  locations. Alternatively \code{x} can be a
  point pattern (object of class \code{"ppp"} or \code{"lpp"}) of
  locations at which the distance function should be computed (and then
  \code{y} should be missing).

  This should be contrasted with the related command \code{\link{distmap}}
  which computes the distance function of \code{X}
  on a grid of locations, and returns the distance
  values in the form of a pixel image.

  The distance values returned by \code{f <- distfun(X); d <- f(x)}
  are computed using coordinate geometry; they are more accurate,
  but slower to compute, than the distance values returned by
  \code{Z <- distmap(X); d <- Z[x]}
  which are computed using a fast recursive algorithm. 
  
  The result of \code{f <- distfun(X)} also belongs to the class
  \code{"funxy"} and to the special class \code{"distfun"}.
  It can be printed and plotted immediately as shown in the Examples.
  
  A \code{distfun} object can be converted to a pixel image
  using \code{\link{as.im}}.
}
\value{
  A \code{function} with arguments \code{x,y}.
  The function belongs to the class \code{"distfun"} which has
  methods for \code{print} and \code{summary}, and for geometric
  operations like \code{shift}.
  It also belongs to the class \code{"funxy"} which has methods
  for \code{plot}, \code{contour} and \code{persp}.
}
\section{Distance values}{
  The values returned by the distance function
  \code{f <- distfun(X)} are distances,
  expressed as multiples of the unit of length of the spatial
  coordinates in \code{X}.
  The unit of length is given by \code{\link{unitname}(X)}.

  Note that, if the unit of length in \code{X} is
  a composite expression such as \sQuote{2 microns},
  then the values of \code{f} are expressed as multiples
  of 2 microns, rather than being expressed in microns.
}
\section{Domain of the function}{
  The domain of the distance function is unbounded,
  that is, the distance function can be evaluated at any spatial location.

  However, when the distance function is plotted by \code{plot},
  \code{contour} or \code{persp}, the function domain is assumed to
  be the rectangular frame surrounding the original object \code{X}.
  To generate a plot of the distance function
  on a different region, use the argument \code{W} in the plot command,
  as explained in the help for \code{\link{plot.funxy}}.
}
\seealso{
  \code{\link{distmap}},
  \code{\link{summary.distfun}},
  \code{\link{methods.distfun}},
  \code{\link{methods.funxy}},
  \code{\link{plot.funxy}}
}
\examples{
   f <- distfun(letterR)
   f
   plot(f)
   f(0.2, 0.3)

   plot(distfun(letterR, invert=TRUE), eps=0.1)

   d <- distfun(cells)
   d2 <- distfun(cells, k=2)
   d(0.5, 0.5)
   d2(0.5, 0.5)
   domain(d)
   summary(d)

   z <- d(japanesepines)
}
\author{
  \spatstatAuthors.
}
\keyword{spatial}
\keyword{math}
