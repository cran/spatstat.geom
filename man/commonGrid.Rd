\name{commonGrid}
\alias{commonGrid}
\title{Determine A Common Spatial Domain And Pixel Resolution}
\description{
  Determine a common spatial domain and pixel resolution for
  several spatial objects such as images, masks, windows
  and point patterns.
}
\usage{
commonGrid(\dots)
}
\arguments{
  \item{\dots}{
    Any number of pixel images (objects of class \code{"im"}),
    binary masks (objects of class \code{"owin"} of type \code{"mask"})
    or data which can be converted to binary masks by \code{\link[spatstat.geom]{as.mask}}.
  } 
}
\details{
  This function determines a common spatial resolution and spatial domain
  for several spatial objects. 

  The arguments \code{\dots} may be pixel images,
  binary masks, or other spatial objects acceptable to \code{\link[spatstat.geom]{as.mask}}.
  
  The common pixel grid is determined by inspecting all the pixel images
  and binary masks in the argument list, finding the pixel grid with the
  highest spatial resolution, and extending this pixel grid to cover the
  bounding box of all the spatial objects.

  The return value is a binary mask \code{M}, representing the bounding box
  at the chosen pixel resolution.
  Use \code{\link{as.im}(X, W=M)} to convert a pixel image \code{X} to this new
  pixel resolution.
  Use \code{\link[spatstat.geom]{as.mask}(W, xy=M)} to convert a window \code{W}
  to a binary mask at this new pixel resolution.
  See the Examples.
}
\value{
  A binary mask (object of class \code{"owin"} and type \code{"mask"}).
}
\author{
  \adrian
  and \rolf
}
\examples{
if(require(spatstat.random)) {
   A <- setcov(square(1), dimyx=32)
   G <- as.im(function(x,y) { x^2 - y }, W=owin(), dimyx=8)
   H <- commonGrid(A, letterR, G)
   newR <- as.mask(letterR, xy=H)
   newG <- as.im(G, W=H)
   if(interactive()) plot(solist(G=newG, R=newR), main="")
}
}
\seealso{
  \code{\link{harmonise.im}},
  \code{\link{compatible.im}},
  \code{\link{as.im}}
}
\keyword{spatial}
\keyword{manip}
