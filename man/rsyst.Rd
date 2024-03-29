\name{rsyst}
\alias{rsyst}
\title{Simulate systematic random point pattern}
\description{
  Generates a \dQuote{systematic random} pattern of points in a window,
  consisting of a grid of equally-spaced points with a random common
  displacement.
}
\usage{
 rsyst(win=square(1), nx=NULL, ny=nx, \dots, dx=NULL, dy=dx,
       nsim=1, drop=TRUE)
}
\arguments{
  \item{win}{
    A window. 
    An object of class \code{\link{owin}},
    or data in any format acceptable to \code{\link{as.owin}()}.
  }
  \item{nx}{Number of columns of grid points in the window.
    Incompatible with \code{dx}.
  }
  \item{ny}{Number of rows of grid points in the window.
    Incompatible with \code{dy}.
  }
  \item{\dots}{Ignored.}
  \item{dx}{Spacing of grid points in \eqn{x} direction.
    Incompatible with \code{nx}.
  }
  \item{dy}{Spacing of grid points in \eqn{y} direction.
    Incompatible with \code{ny}.
  }
  \item{nsim}{Number of simulated realisations to be generated.}
  \item{drop}{
    Logical. If \code{nsim=1} and \code{drop=TRUE} (the default), the
    result will be a point pattern, rather than a list 
    containing a point pattern.
  }
}
\value{
  A point pattern (an object of class \code{"ppp"})
  if \code{nsim=1}, or a list of point patterns if \code{nsim > 1}.
}
\details{
  This function generates a \dQuote{systematic random} pattern
  of points in the window \code{win}. The pattern consists of a
  rectangular grid of points with a random common displacement.

  The grid spacing in the \eqn{x} direction is determined
  either by the number of columns \code{nx} or by the
  horizontal spacing \code{dx}.
  The grid spacing in the \eqn{y} direction is determined
  either by the number of rows \code{ny} or by the
  vertical spacing \code{dy}. 
  
  The grid is then given a random displacement (the common displacement
  of the grid points is a uniformly distributed random vector in the
  tile of dimensions \code{dx, dy}).

  Some of the resulting grid points may lie outside the window
  \code{win}: if they do, they are deleted.  The result is a point
  pattern inside the window \code{win}.

  This function is useful in creating dummy points for quadrature
  schemes (see \code{\link{quadscheme}}) as well as in simulating
  random point patterns.
}
\seealso{
  \code{\link[spatstat.random]{rstrat}},
  \code{\link[spatstat.random]{runifpoint}},
  \code{\link{quadscheme}}
}
\examples{
  X <- rsyst(nx=10)
  plot(X)

  # polygonal boundary
  X <- rsyst(letterR, 5, 10)
  plot(X)
}
\author{\adrian
  
  
  and \rolf
  
}
\keyword{spatial}
\keyword{datagen}

