\name{rlinegrid}
\alias{rlinegrid}
\title{Generate grid of parallel lines with random displacement}
\description{
  Generates a grid of parallel lines, equally spaced, inside the
  specified window.
}
\usage{
  rlinegrid(angle = 45, spacing = 0.1, win = owin())
}
\arguments{
  \item{angle}{Common orientation of the lines, in degrees anticlockwise
    from the x axis.
  }
  \item{spacing}{Spacing between successive lines.}
  \item{win}{Window in which to generate the lines. An object of
    class \code{"owin"} or something acceptable to
    \code{\link{as.owin}}.
  }
}
\details{
  The grid is randomly displaced from the origin.
}
\value{
  A line segment pattern (object of class \code{"psp"}).
}
\seealso{
  \code{\link{psp}},
  \code{\link[spatstat.random]{rpoisline}}
}
\examples{
  plot(rlinegrid(30, 0.05))
}
\author{\adrian
  
  
  and \rolf
  
}
\keyword{spatial}
\keyword{datagen}
