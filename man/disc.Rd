\name{disc}
\alias{disc}
\title{Circular Window}
\description{
Creates a circular window
}
\usage{
 disc(radius=1, centre=c(0,0), \dots,
      mask=FALSE, npoly=128, delta=NULL,
      metric=NULL)
}
\arguments{
  \item{radius}{Radius of the circle.}
  \item{centre}{The centre of the circle.}
  \item{mask}{Logical flag controlling the type of approximation
    to a perfect circle. See Details.
  }
  \item{npoly}{Number of edges of the polygonal approximation,
    if \code{mask=FALSE}. Incompatible with \code{delta}.
  }
  \item{delta}{
    Tolerance of polygonal approximation: the length of arc
    that will be replaced by one edge of the polygon.
    Incompatible with \code{npoly}.
  }
  \item{\dots}{Arguments passed to \code{as.mask} determining the
    pixel resolution, if \code{mask=TRUE}.
  }
  \item{metric}{
    Optional. A distance metric (object of class \code{"metric"}).
    The disc with respect to this metric will be computed.
  }
}
\value{
  An object of class \code{"owin"} (see \code{\link{owin.object}})
  specifying a window. 
}
\details{
  This command creates a window object
  representing a disc, with the given radius and centre.

  By default, the circle is
  approximated by a polygon with \code{npoly} edges.

  If \code{mask=TRUE}, then the disc is approximated by a binary pixel
  mask. The resolution of the mask is controlled by
  the arguments \code{\dots} which are passed to \code{\link[spatstat.geom]{as.mask}}.

  The argument \code{radius} must be a single positive number.
  The argument \code{centre} specifies the disc centre: it can be either 
  a numeric vector of length 2 giving the coordinates,
  or a \code{list(x,y)} giving the coordinates of exactly one point, or a
  point pattern (object of class \code{"ppp"}) containing exactly one
  point.

  If the argument \code{metric} is given, it should be a distance metric
  (object of class \code{"metric"}). The disc with respect to this
  metric will be computed. 
}
\seealso{
  \code{\link{ellipse}},
  \code{\link{discs}},
  \code{\link{owin.object}},
  \code{\link{owin}},
  \code{\link[spatstat.geom]{as.mask}}
}
\note{This function can also be used to generate regular polygons,
  by setting \code{npoly} to a small integer value. For example
  \code{npoly=5} generates a pentagon and \code{npoly=13} a triskaidecagon.
}
\examples{
 # unit disc
 W <- disc()
 # disc of radius 3 centred at x=10, y=5
 W <- disc(3, c(10,5))
 #
 plot(disc())
 plot(disc(mask=TRUE))
 # nice smooth circle
 plot(disc(npoly=256))
 # how to control the resolution of the mask
 plot(disc(mask=TRUE, dimyx=256))
 # check accuracy of approximation
 area(disc())/pi
 area(disc(mask=TRUE))/pi
}
\author{
  \spatstatAuthors.
}
\keyword{spatial}
\keyword{datagen}
 
 
