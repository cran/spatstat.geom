\name{plot.texturemap}
\alias{plot.texturemap}
\title{
  Plot a Texture Map
}
\description{
  Plot a representation of a texture map,
  similar to a plot legend.
}
\usage{
 \method{plot}{texturemap}(x, \dots, main, xlim = NULL, ylim = NULL,
                           vertical = FALSE, axis = TRUE,
                           side = if(vertical) "right" else "bottom",
                           labelmap = NULL, gap = 0.25,
                           spacing = NULL, add = FALSE)
}
\arguments{
  \item{x}{
    Texture map object (class \code{"texturemap"}).
  }
  \item{\dots}{
    Additional graphics arguments passed to
    \code{\link{add.texture}} or \code{\link[graphics]{axis}}.
  }
  \item{main}{
    Main title for plot.
  }
  \item{xlim,ylim}{
    Optional vectors of length 2 giving the \eqn{x} and \eqn{y} limits
    of the plot.
  }
  \item{vertical}{
    Logical value indicating whether to arrange the texture boxes
    in a vertical column (\code{vertical=TRUE} or a horizontal row
    (\code{vertical=FALSE}, the default).
  }
  \item{axis}{
    Logical value indicating whether to plot axis-style labels
    next to the texture boxes.
  }
  \item{side}{
    One of the character strings
    \code{"bottom"}, \code{"left"}, \code{"top"}  or \code{"right"},
    or one of the integers from 1 to 4,
    specifying the position of the axis-style labels,
    if \code{axis=TRUE}.
  }
  \item{labelmap}{
    Optional. A \code{function} which will be applied to the
    data values (the inputs of the texture map) before they are
    displayed on the plot.
  }
  \item{gap}{
    Separation between texture boxes, as a fraction of the
    width or height of a box.
  }
  \item{spacing}{
    Argument passed to \code{\link{add.texture}} controlling the density
    of lines in a texture. Expressed in spatial coordinate units.
  }
  \item{add}{
    Logical value indicating whether to add the graphics to an existing
    plot (\code{add=TRUE}) or to initialise a new plot
    (\code{add=FALSE}, the default).
  }
}
\details{
  A texture map is an association between data values and graphical
  textures. An object of class \code{"texturemap"} represents a texture
  map. Such objects are returned from the plotting function
  \code{\link{textureplot}}, and can be created directly by the function
  \code{\link{texturemap}}.

  This function \code{plot.texturemap} is a method for the generic
  \code{\link{plot}} for the class \code{"texturemap"}. It displays
  a sample of each of the textures in the texture map, in a separate
  box, annotated by the data value which is mapped to that texture.

  The arrangement and position of the boxes is controlled by
  the arguments \code{vertical}, \code{xlim}, \code{ylim} and
  \code{gap}.
}
\value{
  Null.
}
\author{\adrian
  
  
  \rolf
  
  and \ege
}
\seealso{
  \code{\link{texturemap}},
  \code{\link{textureplot}},
  \code{\link{add.texture}}.
}
\examples{
   tm <- texturemap(c("First", "Second", "Third"), 2:4, col=2:4)
   plot(tm, vertical=FALSE)
   ## abbreviate the labels
   plot(tm, labelmap=function(x) substr(x, 1, 2))
}
\keyword{spatial}
\keyword{hplot}
