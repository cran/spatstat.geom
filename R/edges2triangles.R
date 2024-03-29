#
#   edges2triangles.R
#
#   $Revision: 1.18 $  $Date: 2022/05/21 09:52:11 $
#

edges2triangles <- function(iedge, jedge, nvert=max(iedge, jedge),
                            ..., check=TRUE, friendly=rep(TRUE, nvert)) {
  usefriends <- !missing(friendly)
  if(check) {
    stopifnot(length(iedge) == length(jedge))
    stopifnot(all(iedge > 0))
    stopifnot(all(jedge > 0))
    if(!missing(nvert)) {
      stopifnot(all(iedge <= nvert))
      stopifnot(all(jedge <= nvert))
    }
    if(usefriends) {
      stopifnot(is.logical(friendly))
      stopifnot(length(friendly) == nvert)
      usefriends <- !all(friendly)
    }
  }
  # zero length data, or not enough to make triangles
  if(length(iedge) < 3)
    return(matrix(integer(0), nrow=0, ncol=3,
                  dimnames=list(NULL, c("i", "j", "k"))))
  # sort in increasing order of 'iedge'
  oi <- fave.order(iedge)
  iedge <- iedge[oi]
  jedge <- jedge[oi]
  # call C
  storage.mode(nvert) <- storage.mode(iedge) <- storage.mode(jedge) <- "integer"
  if(usefriends) {
    fr <- as.logical(friendly)
    storage.mode(fr) <- "integer"
    zz <- .Call(SG_trioxgraph,
                nv=nvert, iedge=iedge, jedge=jedge, friendly=fr,
                PACKAGE="spatstat.geom")
    } else if(spatstat.options("fast.trigraph")) {
    zz <- .Call(SG_triograph,
                nv=nvert, iedge=iedge, jedge=jedge,
                PACKAGE="spatstat.geom")
  } else {
    #' testing purposes only
    zz <- .Call(SG_trigraph,
                nv=nvert, iedge=iedge, jedge=jedge,
                PACKAGE="spatstat.geom")
  }
  mat <- as.matrix(as.data.frame(zz, col.names=c("i", "j", "k")))
  return(mat)
}

# compute triangle diameters as well

trianglediameters <- function(iedge, jedge, edgelength, ..., 
                              nvert=max(iedge, jedge),
                              dmax=Inf, check=TRUE) {
  if(check) {
    stopifnot(length(iedge) == length(jedge))
    stopifnot(length(iedge) == length(edgelength))
    stopifnot(all(iedge > 0))
    stopifnot(all(jedge > 0))
    if(!missing(nvert)) {
      stopifnot(all(iedge <= nvert))
      stopifnot(all(jedge <= nvert))
    }
    if(is.finite(dmax)) check.1.real(dmax)
  }
  # zero length data
  if(length(iedge) == 0 || dmax < 0)
    return(data.frame(i=integer(0),
                      j=integer(0),
                      k=integer(0),
                      diam=numeric(0)))

  # call C
  storage.mode(nvert) <- storage.mode(iedge) <- storage.mode(jedge) <- "integer"
  storage.mode(edgelength) <- "double"
  if(is.infinite(dmax)) {
    zz <- .Call(SG_triDgraph,
                nv=nvert, iedge=iedge, jedge=jedge, edgelength=edgelength,
                PACKAGE="spatstat.geom")
  } else {
    storage.mode(dmax) <- "double"
    zz <- .Call(SG_triDRgraph,
                nv=nvert, iedge=iedge, jedge=jedge, edgelength=edgelength,
                dmax=dmax,
                PACKAGE="spatstat.geom")
  }    
  df <- as.data.frame(zz)
  colnames(df) <- c("i", "j", "k", "diam")
  return(df)
}

closetriples <- function(X, rmax) {
  a <- closepairs(X, rmax, what="ijd", twice=FALSE, neat=FALSE)
  tri <- trianglediameters(a$i, a$j, a$d, nvert=npoints(X), dmax=rmax)
  return(tri)
}

# extract 'vees', i.e. triples (i, j, k) where i ~ j and i ~ k

edges2vees <- function(iedge, jedge, nvert=max(iedge, jedge),
                            ..., check=TRUE) {
  if(check) {
    stopifnot(length(iedge) == length(jedge))
    stopifnot(all(iedge > 0))
    stopifnot(all(jedge > 0))
    if(!missing(nvert)) {
      stopifnot(all(iedge <= nvert))
      stopifnot(all(jedge <= nvert))
    }
  }
  # zero length data, or not enough to make vees
  if(length(iedge) < 2)
    return(data.frame(i=numeric(0),
                      j=numeric(0),
                      k=numeric(0)))
  ## call
  vees <- .Call(SG_graphVees,
                nv = nvert,
                iedge = iedge,
                jedge = jedge,
                PACKAGE="spatstat.geom")
  names(vees) <- c("i", "j", "k")
  vees <- as.data.frame(vees)
  return(vees)
}

  
