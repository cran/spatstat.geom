\name{nndist}
\alias{nndist}
\alias{nndist.ppp}
\alias{nndist.default}
\title{Nearest neighbour distances}
\description{
  Computes the distance from each point to its nearest neighbour
  in a point pattern. Alternatively computes the distance to the
  second nearest neighbour, or third nearest, etc.
}
\usage{
  nndist(X, \dots)
  \method{nndist}{ppp}(X, \dots, k=1, by=NULL, proper=FALSE, method="C", metric=NULL)
  \method{nndist}{default}(X, Y=NULL, \dots, k=1, by=NULL, method="C")
}
\arguments{
  \item{X,Y}{
    Arguments specifying the locations of
    a set of points.
    For \code{nndist.ppp}, the argument \code{X} should be a point
    pattern (object of class \code{"ppp"}).
    For \code{nndist.default}, typically \code{X} and \code{Y} would be
    numeric vectors of equal length. Alternatively \code{Y} may be
    omitted and \code{X} may be
    a list with two components \code{x} and \code{y},
    or a matrix with two columns.
    Alternatively \code{X} can be
    a three-dimensional point pattern (class \code{"pp3"}),
    a higher-dimensional point pattern (class \code{"ppx"}),
    a point pattern on a linear network (class \code{"lpp"}),
    or a spatial pattern of line segments (class \code{"psp"}).
  }
  \item{\dots}{
    Ignored by \code{nndist.ppp}
    and \code{nndist.default}.
  }
  \item{k}{
    Integer, or integer vector. The algorithm will compute the distance to the
    \code{k}th nearest neighbour. 
  }
  \item{by}{
    Optional. A factor, which separates \code{X} into groups.
    The algorithm will compute the distance to the nearest point in each
    group. See Details.
  }
  \item{proper}{
    Logical value specifying whether to measure distances
    only between distinct points (\code{proper=TRUE}) or
    to include distances between data points at the same spatial
    location (\code{proper=FALSE}, the default).
    See Details.
  }
  \item{method}{String specifying which method of calculation to use.
    Values are \code{"C"} and \code{"interpreted"}.
  }
  \item{metric}{
    Optional. A metric (object of class \code{"metric"})
    that will be used to define and compute the distances.
  }
}
\value{
  Numeric vector or matrix containing the 
  nearest neighbour distances for each point.

  If \code{k = 1} (the default), the return value is a
  numeric vector \code{v} such that \code{v[i]} is the
  nearest neighbour distance for the \code{i}th data point.
  
  If \code{k} is a single integer, then the return value is a
  numeric vector \code{v} such that \code{v[i]} is the
  \code{k}th nearest neighbour distance for the
  \code{i}th data point.

  If \code{k} is a vector, then the return value is a
  matrix \code{m} such that \code{m[i,j]} is the
  \code{k[j]}th nearest neighbour distance for the
  \code{i}th data point.

  If the argument \code{by} is given, then it should be a \code{factor}
  which separates \code{X} into groups (or any type of data acceptable to
  \code{\link{split.ppp}} that determines the grouping).
  The result is a data frame containing the distances described above,
  from each point of \code{X},
  to the nearest point in each subset of \code{X}
  defined by the grouping factor \code{by}.
}
\details{
  This function computes the Euclidean distance from each point
  in a point pattern to its nearest neighbour (the nearest other
  point of the pattern). If \code{k} is specified, it computes the
  distance to the \code{k}th nearest neighbour.

  The function \code{nndist} is generic, with
  a method for point patterns (objects of class \code{"ppp"}),
  and a default method for coordinate vectors.

  There are also methods for line segment patterns,
  \code{\link{nndist.psp}},
  three-dimensional point patterns, \code{\link{nndist.pp3}},
  higher-dimensional point patterns, \code{\link{nndist.ppx}}
  and point patterns on a linear network,
  \code{nndist.lpp};
  these are described in their own help files.
  Type \code{methods(nndist)} to see all available methods.

  The method for planar point patterns \code{nndist.ppp} expects a single
  point pattern argument \code{X} and returns the vector of its
  nearest neighbour distances.

  The default method expects that \code{X} and \code{Y} will determine
  the coordinates of a set of points. Typically \code{X} and
  \code{Y} would be numeric vectors of equal length. Alternatively
  \code{Y} may be omitted and \code{X} may be a list with two components
  named \code{x} and \code{y}, or a matrix or data frame with two columns.
  
  The argument \code{k} may be a single integer, or an integer vector.
  If it is a vector, then the \eqn{k}th nearest neighbour distances are
  computed for each value of \eqn{k} specified in the vector.

  If the argument \code{by} is given, it should be a \code{factor},
  of length equal to the number of points in \code{X}.
  This factor effectively partitions \code{X} into subsets,
  each subset associated with one of the levels of \code{X}.
  The algorithm will then compute, for each point of \code{X},
  the distance to the nearest neighbour \emph{in each subset}.

  If \code{proper=FALSE} (the default),
  data points which lie at the same spatial location
  are treated as different individuals, and the
  nearest-neighbour distance for any such point is defined to be zero.
  If \code{proper=TRUE}, only distances between distinct points are
  included in the calculation, so the nearest-neighbour distance is
  always nonzero (or \code{NA} if there are not enough data points).
  
  The argument \code{method} is not normally used. It is
  retained only for checking the validity of the software.
  If \code{method = "interpreted"} then the distances are
  computed using interpreted R code only. If \code{method="C"}
  (the default) then C code is used. 
  The C code is faster by two to three orders of magnitude
  and uses much less memory.

  If there is only one point (if \code{x} has length 1),
  then a nearest neighbour distance of \code{Inf} is returned.
  If there are no points (if \code{x} has length zero)
  a numeric vector of length zero is returned.

  To identify \emph{which} point is the nearest neighbour of a given point,
  use \code{\link{nnwhich}}.

  To use the nearest neighbour distances for statistical inference,
  it is often advisable to use the edge-corrected empirical distribution,
  computed by \code{\link[spatstat.explore]{Gest}}.

  To find the nearest neighbour distances from one point pattern
  to another point pattern, use \code{\link{nncross}}.
}
\section{Nearest neighbours of each type}{
  If \code{X} is a multitype point pattern 
  and \code{by=marks(X)}, then the algorithm will compute,
  for each point of \code{X}, the distance to the nearest neighbour
  of each type. See the Examples.

  To find the minimum distance from \emph{any} point of type \code{i}
  to the nearest point of type \code{j}, for all combinations of \code{i} and
  \code{j}, use \code{\link{minnndist}},
  or the \R function \code{\link[stats]{aggregate}} as
  suggested in the Examples.
}
\section{Warnings}{
  An infinite or \code{NA} value is returned if the
  distance is not defined (e.g. if there is only one point
  in the point pattern).
}
\section{Distance values}{
  The values returned by \code{nndist(X)} are distances,
  expressed as multiples of the unit of length of the spatial
  coordinates in \code{X}.
  The unit of length is given by \code{\link{unitname}(X)}.

  Note that, if the unit of length in \code{X} is a composite
  expression such as \sQuote{2 microns},
  then the values of \code{nndist(X)} are expressed as multiples
  of 2 microns, rather than being expressed in microns.
}
\seealso{
  \code{\link{nndist.psp}},
  \code{\link{nndist.pp3}},
  \code{\link{nndist.ppx}},
  \code{\link{pairdist}},
  \code{\link[spatstat.explore]{Gest}},
  \code{\link{nnwhich}},
  \code{\link{nncross}},
  \code{\link{minnndist}}, \code{\link{maxnndist}}.
}
\examples{
   # nearest neighbours
   d <- nndist(cells)

   # second nearest neighbours
   d2 <- nndist(cells, k=2)

   # first, second and third nearest
   d1to3 <- nndist(cells, k=1:3)

   x <- runif(100)
   y <- runif(100)
   d <- nndist(x, y)

   # Stienen diagram
   plot(cells \%mark\% nndist(cells), markscale=1)

   # distance to nearest neighbour of each type
   nnda <- nndist(ants, by=marks(ants)) 
   head(nnda)
   # For nest number 1, the nearest Cataglyphis nest is 87.32125 units away

   # minimum distance between each pair of types
   minnndist(ants, by=marks(ants))

   # Use of 'aggregate':
   # _minimum_ distance between each pair of types
   aggregate(nnda, by=list(from=marks(ants)), min)
   # _mean_ nearest neighbour distances
   aggregate(nnda, by=list(from=marks(ants)), mean)
   # The mean distance from a Messor nest to
   # the nearest Cataglyphis nest is 59.02549 units
}
\author{
  \pavel
  and
  \adrian.
}
\keyword{spatial}
\keyword{math}

