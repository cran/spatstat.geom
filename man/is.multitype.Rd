\name{is.multitype}
\alias{is.multitype}
\title{Test whether Object is Multitype}
\description{
  Generic function to test whether a given object (usually a point
  pattern or something related to a point pattern) has ``marks''
  attached to the points which classify the points into several types.
}
\usage{
  is.multitype(X, \dots) 
}
\arguments{
  \item{X}{
    Object to be inspected
  }
  \item{\dots}{
    Other arguments.
  }
}
\value{
  Logical value, equal to \code{TRUE} if \code{X} is multitype.
}
\details{
  ``Marks'' are observations attached to each point of a point pattern.
  For example the \code{\link[spatstat.data]{longleaf}} dataset
  contains the locations of trees, each tree being marked by its diameter;
  the \code{\link[spatstat.data]{amacrine}} dataset gives the locations of cells
  of two types (on/off) and the type of cell may be regarded as a mark attached
  to the location of the cell.
  Other objects related to point patterns, such as point process models,
  may involve marked points.

  This function tests whether the object \code{X}
  contains or involves marked points, \bold{and} that the
  marks are a factor.

  For example, the \code{\link[spatstat.data]{amacrine}}
  dataset is multitype (there are two types of cells, on and off),
  but the \code{\link[spatstat.data]{longleaf}} dataset is \emph{not} multitype
  (the marks are real numbers).
  
  This function is generic; methods are provided
  for point patterns (objects of class \code{"ppp"})
  and point process models (objects of class \code{"ppm"}).
}
\seealso{
  \code{\link{is.multitype.ppp}},
  \code{\link[spatstat.model]{is.multitype.ppm}}
}
\author{\adrian
  
  
  and \rolf
  
}
\keyword{spatial}
\keyword{manip}
