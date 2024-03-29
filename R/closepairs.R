#
# closepairs.R
#
#   $Revision: 1.54 $   $Date: 2022/06/15 01:35:50 $
#
#  simply extract the r-close pairs from a dataset
# 
#  Less memory-hungry for large patterns
#

closepairs <- function(X, rmax, ...) {
  UseMethod("closepairs")
}
  
closepairs.ppp <- function(X, rmax, twice=TRUE,
                           what=c("all", "indices", "ijd"),
                           distinct=TRUE, neat=TRUE,
                           periodic=FALSE,
                           ...) {
  verifyclass(X, "ppp")
  what <- match.arg(what)
  stopifnot(is.numeric(rmax) && length(rmax) == 1L)
  stopifnot(is.finite(rmax))
  stopifnot(rmax >= 0)
  ordered <- list(...)$ordered
  if(missing(twice) && !is.null(ordered)) {
    warning("Obsolete argument 'ordered' has been replaced by 'twice'")
    twice <- ordered
  }
  if(periodic && !is.rectangle(Window(X)))
    warning("Periodic edge correction applied in non-rectangular window",
            call.=FALSE)
  
  npts <- npoints(X)
  null.answer <- switch(what,
                        all = {
                          list(i=integer(0),
                               j=integer(0),
                               xi=numeric(0),
                               yi=numeric(0),
                               xj=numeric(0),
                               yj=numeric(0),
                               dx=numeric(0),
                               dy=numeric(0),
                               d=numeric(0))
                        },
                        indices = {
                          list(i=integer(0),
                               j=integer(0))
                        },
                        ijd = {
                          list(i=integer(0),
                               j=integer(0),
                               d=numeric(0))
                        })
  if(npts == 0)
    return(null.answer)
  ## sort points by increasing x coordinate
  if(!periodic) {
    oo <- fave.order(X$x)
    Xsort <- X[oo]
  } 
  ## First make an OVERESTIMATE of the number of unordered pairs
  nsize <- list(...)$nsize # secret option to test memory overflow code
  if(!is.null(nsize)) {
    splat("Using nsize =", nsize)
  } else {
    #' normal usage
    #' calculate a conservative estimate of the number of pairs
    npairs <- as.double(npts)^2
    if(npairs <= 1024) {
      nsize <- 1024
    } else {
      catchfraction <- pi * (rmax^2)/area(Frame(X))
      nsize <- ceiling(2 * catchfraction * npairs)
      nsize <- min(nsize, npairs)
      nsize <- max(1024, nsize)
      if(nsize > .Machine$integer.max) {
        warning(
          "Estimated number of close pairs exceeds maximum possible integer",
          call.=FALSE)
        nsize <- .Machine$integer.max
      }
    }
  }
  ## Now extract pairs
  if(periodic) {
    ## special algorithm for periodic distance
    got.twice <- TRUE
    x <- X$x
    y <- X$y
    r <- rmax
    p <- sidelengths(Frame(X))
    ng <- nsize
    storage.mode(x) <- "double"
    storage.mode(y) <- "double"
    storage.mode(r) <- "double"
    storage.mode(p) <- "double"
    storage.mode(ng) <- "integer"
    z <- .Call(SG_closePpair,
               xx=x,
               yy=y,
               pp=p,
               rr=r,
               nguess=ng,
               PACKAGE="spatstat.geom")
    i <- z[[1L]]
    j <- z[[2L]]
    d <- z[[3L]]
    if(what == "all") {
      xi <- x[i]
      yi <- y[i]
      xj <- x[j]
      yj <- y[j]
      dx <- xj - xi
      dy <- yj - yi
    }
  } else if(spatstat.options("closepairs.newcode")) {
    # ------------------- use new faster code ---------------------
    # fast algorithms collect each distinct pair only once
    got.twice <- FALSE
    ng <- nsize
    #
    x <- Xsort$x
    y <- Xsort$y
    r <- rmax
    storage.mode(x) <- "double"
    storage.mode(y) <- "double"
    storage.mode(r) <- "double"
    storage.mode(ng) <- "integer"
    switch(what,
           all = {
             z <- .Call(SG_Vclosepairs,
                        xx=x, yy=y, rr=r, nguess=ng,
                        PACKAGE="spatstat.geom")
             if(length(z) != 9)
               stop("Internal error: incorrect format returned from Vclosepairs")
             i  <- z[[1L]]  # NB no increment required
             j  <- z[[2L]]
             xi <- z[[3L]]
             yi <- z[[4L]]
             xj <- z[[5L]]
             yj <- z[[6L]]
             dx <- z[[7L]]
             dy <- z[[8L]]
             d  <- z[[9L]]
           },
             indices = {
             z <- .Call(SG_VcloseIJpairs,
                        xx=x, yy=y, rr=r, nguess=ng,
                        PACKAGE="spatstat.geom")
             if(length(z) != 2)
               stop("Internal error: incorrect format returned from VcloseIJpairs")
             i  <- z[[1L]]  # NB no increment required
             j  <- z[[2L]]
           },
               ijd = {
             z <- .Call(SG_VcloseIJDpairs,
                        xx=x, yy=y, rr=r, nguess=ng,
                        PACKAGE="spatstat.geom")
             if(length(z) != 3)
               stop("Internal error: incorrect format returned from VcloseIJDpairs")
             i  <- z[[1L]]  # NB no increment required
             j  <- z[[2L]]
             d  <- z[[3L]]
           })

  } else if(spatstat.options("closepairs.altcode")) {
    #' experimental alternative code
    got.twice <- FALSE
    ng <- nsize
    #
    x <- Xsort$x
    y <- Xsort$y
    r <- rmax
    storage.mode(x) <- "double"
    storage.mode(y) <- "double"
    storage.mode(r) <- "double"
    storage.mode(ng) <- "integer"
    switch(what,
           all = {
             z <- .Call(SG_altVclosepairs,
                        xx=x, yy=y, rr=r, nguess=ng,
                        PACKAGE="spatstat.geom")
             if(length(z) != 9)
               stop("Internal error: incorrect format returned from altVclosepairs")
             i  <- z[[1L]]  # NB no increment required
             j  <- z[[2L]]
             xi <- z[[3L]]
             yi <- z[[4L]]
             xj <- z[[5L]]
             yj <- z[[6L]]
             dx <- z[[7L]]
             dy <- z[[8L]]
             d  <- z[[9L]]
           },
             indices = {
             z <- .Call(SG_altVcloseIJpairs,
                        xx=x, yy=y, rr=r, nguess=ng,
                        PACKAGE="spatstat.geom")
             if(length(z) != 2)
               stop("Internal error: incorrect format returned from altVcloseIJpairs")
             i  <- z[[1L]]  # NB no increment required
             j  <- z[[2L]]
           },
               ijd = {
             z <- .Call(SG_altVcloseIJDpairs,
                        xx=x, yy=y, rr=r, nguess=ng,
                        PACKAGE="spatstat.geom")
             if(length(z) != 3)
               stop("Internal error: incorrect format returned from altVcloseIJDpairs")
             i  <- z[[1L]]  # NB no increment required
             j  <- z[[2L]]
             d  <- z[[3L]]
           })

  } else {
    # ------------------- use older code --------------------------
    if(!distinct) {
      ii <- seq_len(npts)
      xx <- X$x
      yy <- X$y
      zeroes <- rep(0, npts)
      null.answer <- switch(what,
                            all = {
                              list(i=ii,
                                   j=ii,
                                   xi=xx,
                                   yi=yy,
                                   xj=xx,
                                   yj=yy,
                                   dx=zeroes,
                                   dy=zeroes,
                                   d=zeroes)
                            },
                            indices = {
                              list(i=ii,
                                   j=ii)
                            },
                            ijd = {
                              list(i=ii,
                                   j=ii,
                                   d=zeroes)
                            })
    }

    got.twice <- TRUE
    nsize <- as.integer(min(as.double(nsize) * 2, as.double(.Machine$integer.max)))
    z <-
      .C(SG_Fclosepairs,
         nxy=as.integer(npts),
         x=as.double(Xsort$x),
         y=as.double(Xsort$y),
         r=as.double(rmax),
         noutmax=as.integer(nsize), 
         nout=as.integer(integer(1L)),
         iout=as.integer(integer(nsize)),
         jout=as.integer(integer(nsize)), 
         xiout=as.double(numeric(nsize)),
         yiout=as.double(numeric(nsize)),
         xjout=as.double(numeric(nsize)),
         yjout=as.double(numeric(nsize)),
         dxout=as.double(numeric(nsize)),
         dyout=as.double(numeric(nsize)),
         dout=as.double(numeric(nsize)),
         status=as.integer(integer(1L)),
         PACKAGE="spatstat.geom")

    if(z$status != 0) {
      # Guess was insufficient
      # Obtain an OVERCOUNT of the number of pairs
      # (to work around gcc bug #323)
      rmaxplus <- 1.25 * rmax
      nsize <- .C(SG_paircount,
                  nxy=as.integer(npts),
                  x=as.double(Xsort$x),
                  y=as.double(Xsort$y),
                  rmaxi=as.double(rmaxplus),
                  count=as.integer(integer(1L)),
                  PACKAGE="spatstat.geom")$count
      if(nsize <= 0)
        return(null.answer)
      # add a bit more for safety
      nsize <- ceiling(1.1 * nsize) + 2 * npts
      # now extract points
      z <-
        .C(SG_Fclosepairs,
           nxy=as.integer(npts),
           x=as.double(Xsort$x),
           y=as.double(Xsort$y),
           r=as.double(rmax),
           noutmax=as.integer(nsize), 
           nout=as.integer(integer(1L)),
           iout=as.integer(integer(nsize)),
           jout=as.integer(integer(nsize)), 
           xiout=as.double(numeric(nsize)),
           yiout=as.double(numeric(nsize)),
           xjout=as.double(numeric(nsize)),
           yjout=as.double(numeric(nsize)),
           dxout=as.double(numeric(nsize)),
           dyout=as.double(numeric(nsize)),
           dout=as.double(numeric(nsize)),
           status=as.integer(integer(1L)),
           PACKAGE="spatstat.geom")
      if(z$status != 0)
        stop(paste("Internal error: C routine complains that insufficient space was allocated:", nsize))
    }
  # trim vectors to the length indicated
    npairs <- z$nout
    if(npairs <= 0)
      return(null.answer)
    actual <- seq_len(npairs)
    i  <- z$iout[actual]  # sic
    j  <- z$jout[actual]
    switch(what,
           indices={},
           all={
             xi <- z$xiout[actual]
             yi <- z$yiout[actual]
             xj <- z$xjout[actual]
             yj <- z$yjout[actual]
             dx <- z$dxout[actual]
             dy <- z$dyout[actual]
             d <-  z$dout[actual]
           },
           ijd = {
             d <- z$dout[actual]
           })
    # ------------------- end code switch ------------------------
  }
  
  if(!periodic) {
    ## convert i,j indices to original sequence
    i <- oo[i]
    j <- oo[j]
  }
  
  if(twice) {
    ## both (i, j) and (j, i) should be returned
    if(!got.twice) {
      ## duplication required
      iold <- i
      jold <- j
      i <- c(iold, jold)
      j <- c(jold, iold)
      switch(what,
             indices = { },
             ijd = {
               d <- rep(d, 2)
             },
             all = {
               xinew <- c(xi, xj)
               yinew <- c(yi, yj)
               xjnew <- c(xj, xi)
               yjnew <- c(yj, yi)
               xi <- xinew
               yi <- yinew
               xj <- xjnew
               yj <- yjnew
               dx <- c(dx, -dx)
               dy <- c(dy, -dy)
               d <- rep(d, 2)
             })
    }
  } else {
    ## only one of (i, j) and (j, i) should be returned
    if(got.twice) {
      ## remove duplication
      ok <- (i < j)
      i  <-  i[ok]
      j  <-  j[ok]
      switch(what,
             indices = { },
             all = {
               xi <- xi[ok]
               yi <- yi[ok]
               xj <- xj[ok]
               yj <- yj[ok]
               dx <- dx[ok]
               dy <- dy[ok]
               d  <-  d[ok]
             },
             ijd = {
               d  <-  d[ok]
             })
    } else if(neat) {
      ## enforce i < j
      swap <- (i > j)
      tmp <- i[swap]
      i[swap] <- j[swap]
      j[swap] <- tmp
      if(what == "all") {
        xinew <- ifelse(swap, xj, xi)
        yinew <- ifelse(swap, yj, yi)
        xjnew <- ifelse(swap, xi, xj)
        yjnew <- ifelse(swap, yi, yj)
        xi <- xinew
        yi <- yinew
        xj <- xjnew
        yj <- yjnew
        dx[swap] <- -dx[swap]
        dy[swap] <- -dy[swap]
      }
    } ## otherwise no action required
  }
  ## add pairs of identical points?
  if(!distinct) {
    ii <- seq_len(npts)
    xx <- X$x
    yy <- X$y
    zeroes <- rep(0, npts)
    i <- c(i, ii)
    j <- c(j, ii)
    switch(what,
           ijd={
             d  <- c(d, zeroes)
           },
           all = {
             xi <- c(xi, xx)
             yi <- c(yi, yy)
             xj <- c(xj, xx)
             yj <- c(yj, yy)
             dx <- c(dx, zeroes)
             dy <- c(dy, zeroes)
             d  <- c(d, zeroes)
           })
  }
  ## done
  switch(what,
         all = {
           answer <- list(i=i,
                          j=j,
                          xi=xi, 
                          yi=yi,
                          xj=xj,
                          yj=yj,
                          dx=dx,
                          dy=dy,
                          d=d)
         },
         indices = {
           answer <- list(i = i, j = j)
         },
         ijd = {
           answer <- list(i=i, j=j, d=d)
         })
  return(answer)
}

#######################

crosspairs <- function(X, Y, rmax, ...) {
  UseMethod("crosspairs")
}

crosspairs.ppp <- function(X, Y, rmax,
                           what=c("all", "indices", "ijd"),
                           periodic=FALSE, ...,
                           iX=NULL, iY=NULL) {
  verifyclass(X, "ppp")
  verifyclass(Y, "ppp")
  what <- match.arg(what)
  stopifnot(is.numeric(rmax) && length(rmax) == 1L && rmax >= 0)
  null.answer <- switch(what,
                        all = {
                          list(i=integer(0),
                               j=integer(0),
                               xi=numeric(0),
                               yi=numeric(0),
                               xj=numeric(0),
                               yj=numeric(0),
                               dx=numeric(0),
                               dy=numeric(0),
                               d=numeric(0))
                        },
                        indices = {
                          list(i=integer(0),
                               j=integer(0))
                        },
                        ijd = {
                          list(i=integer(0),
                               j=integer(0),
                               d=numeric(0))
                        })
  nX <- npoints(X)
  nY <- npoints(Y)
  if(nX == 0 || nY == 0) return(null.answer)
  nXY <- as.double(nX) * as.double(nY)
  if(periodic) {
    ## ............... Periodic distance ..................
    if(!is.rectangle(Window(Y)))
      warning("Periodic edge correction applied in non-rectangular window",
              call.=FALSE)
    ## Overestimate the number of pairs
    if(nXY <= 1024) {
      nsize <- 1024
    } else {
      catchfraction <- pi * (rmax^2)/area(Frame(Y))
      nsize <- ceiling(2 * catchfraction * nXY)
      nsize <- min(nsize, nXY)
      nsize <- max(1024, nsize)
      if(nsize > .Machine$integer.max) {
        warning(
          "Estimated number of close pairs exceeds maximum possible integer",
          call.=FALSE)
        nsize <- .Machine$integer.max
      }
    }
    # .Call
    Xx <- X$x
    Xy <- X$y
    Yx <- Y$x
    Yy <- Y$y
    per <- sidelengths(Frame(Y))
    r <- rmax
    ng <- nsize
    storage.mode(Xx) <- storage.mode(Xy) <- "double"
    storage.mode(Yx) <- storage.mode(Yy) <- "double"
    storage.mode(per) <- storage.mode(r) <- "double"
    storage.mode(ng) <- "integer"
    z <- .Call(SG_crossPpair,
               xxA=Xx, yyA=Xy,
               xxB=Yx, yyB=Yy,
               pp=per, rr=r, nguess=ng,
               PACKAGE="spatstat.geom")
    if(length(z) != 3)
      stop("Internal error: incorrect format returned from crossPpair")
    i  <- z[[1L]]  # NB no increment required
    j  <- z[[2L]]
    d  <- z[[3L]]
    answer <- switch(what,
                     indices = list(i=i, j=j),
                     ijd =     list(i=i, j=j, d=d),
                     all = {
                       xi <- Xx[i]
                       yi <- Xy[i]
                       xj <- Yx[j]
                       yj <- Yy[j]
                       dx <- xj-xi
                       dy <- yj-yi
                       list(i=i,
                            j=j,
                            xi=xi, 
                            yi=yi,
                            xj=xj,
                            yj=yj,
                            dx=dx,
                            dy=dy,
                            d=d)
                     })
    if(!is.null(iX) && !is.null(iY))
      answer <- remove.identical.pairs(answer, iX, iY)
    return(answer)
  }
  ## .......... Euclidean distance .......................
  ## order patterns by increasing x coordinate
  ooX <- fave.order(X$x)
  Xsort <- X[ooX]
  ooY <- fave.order(Y$x)
  Ysort <- Y[ooY]
  if(spatstat.options("crosspairs.newcode")) {
    ## ------------------- use new faster code ---------------------
    ## First (over)estimate the number of pairs
    nXY <- as.double(nX) * as.double(nY)
    if(nXY <= 1024) {
      nsize <- 1024
    } else {
      catchfraction <- pi * (rmax^2)/area(Frame(Y))
      nsize <- ceiling(2 * catchfraction * nXY)
      nsize <- min(nsize, nXY)
      nsize <- max(1024L, nsize)
      if(nsize > .Machine$integer.max) {
        warning(
          "Estimated number of close pairs exceeds maximum possible integer",
          call.=FALSE)
        nsize <- .Machine$integer.max
      }
    }
    # .Call
    Xx <- Xsort$x
    Xy <- Xsort$y
    Yx <- Ysort$x
    Yy <- Ysort$y
    r <- rmax
    ng <- nsize
    storage.mode(Xx) <- storage.mode(Xy) <- "double"
    storage.mode(Yx) <- storage.mode(Yy) <- "double"
    storage.mode(r) <- "double"
    storage.mode(ng) <- "integer"
    switch(what,
           all = {
             z <- .Call(SG_Vcrosspairs,
                        xx1=Xx, yy1=Xy,
                        xx2=Yx, yy2=Yy,
                        rr=r, nguess=ng,
                        PACKAGE="spatstat.geom")
             if(length(z) != 9)
               stop("Internal error: incorrect format returned from Vcrosspairs")
             i  <- z[[1L]]  # NB no increment required
             j  <- z[[2L]]
             xi <- z[[3L]]
             yi <- z[[4L]]
             xj <- z[[5L]]
             yj <- z[[6L]]
             dx <- z[[7L]]
             dy <- z[[8L]]
             d  <- z[[9L]]
           },
             indices = {
             z <- .Call(SG_VcrossIJpairs,
                        xx1=Xx, yy1=Xy,
                        xx2=Yx, yy2=Yy,
                        rr=r, nguess=ng,
                        PACKAGE="spatstat.geom")
             if(length(z) != 2)
               stop("Internal error: incorrect format returned from VcrossIJpairs")
             i  <- z[[1L]]  # NB no increment required
             j  <- z[[2L]]
           }, 
               ijd = {
             z <- .Call(SG_VcrossIJDpairs,
                        xx1=Xx, yy1=Xy,
                        xx2=Yx, yy2=Yy,
                        rr=r, nguess=ng,
                        PACKAGE="spatstat.geom")
             if(length(z) != 3)
               stop("Internal error: incorrect format returned from VcrossIJDpairs")
             i  <- z[[1L]]  # NB no increment required
             j  <- z[[2L]]
             d  <- z[[3L]]
           })
           
  } else {
    # Older code 
    # obtain upper estimate of number of pairs
    # (to work around gcc bug 323)
    rmaxplus <- 1.25 * rmax
    nsize <- .C(SG_crosscount,
                nn1=as.integer(X$n),
                x1=as.double(Xsort$x),
                y1=as.double(Xsort$y),
                nn2=as.integer(Ysort$n),
                x2=as.double(Ysort$x),
                y2=as.double(Ysort$y),
                rmaxi=as.double(rmaxplus),
                count=as.integer(integer(1L)),
                PACKAGE="spatstat.geom")$count
    if(nsize <= 0)
      return(null.answer)

    # allow slightly more space to work around gcc bug #323
    nsize <- ceiling(1.1 * nsize) + X$n + Y$n
    
    # now extract pairs
    z <-
      .C(SG_Fcrosspairs,
         nn1=as.integer(X$n),
         x1=as.double(Xsort$x),
         y1=as.double(Xsort$y),
         nn2=as.integer(Y$n),
         x2=as.double(Ysort$x),
         y2=as.double(Ysort$y),
         r=as.double(rmax),
         noutmax=as.integer(nsize), 
         nout=as.integer(integer(1L)),
         iout=as.integer(integer(nsize)),
         jout=as.integer(integer(nsize)), 
         xiout=as.double(numeric(nsize)),
         yiout=as.double(numeric(nsize)),
         xjout=as.double(numeric(nsize)),
         yjout=as.double(numeric(nsize)),
         dxout=as.double(numeric(nsize)),
         dyout=as.double(numeric(nsize)),
         dout=as.double(numeric(nsize)),
         status=as.integer(integer(1L)),
         PACKAGE="spatstat.geom")
    if(z$status != 0)
      stop(paste("Internal error: C routine complains that insufficient space was allocated:", nsize))
    # trim vectors to the length indicated
    npairs <- z$nout
    if(npairs <= 0)
      return(null.answer)
    actual <- seq_len(npairs)
    i  <- z$iout[actual] # sic
    j  <- z$jout[actual] 
    xi <- z$xiout[actual]
    yi <- z$yiout[actual]
    xj <- z$xjout[actual]
    yj <- z$yjout[actual]
    dx <- z$dxout[actual]
    dy <- z$dyout[actual]
    d <-  z$dout[actual]
  }
  # convert i,j indices to original sequences
  i <- ooX[i]
  j <- ooY[j]
  # done
  switch(what,
         all = {
           answer <- list(i=i,
                          j=j,
                          xi=xi, 
                          yi=yi,
                          xj=xj,
                          yj=yj,
                          dx=dx,
                          dy=dy,
                          d=d)
         },
         indices = {
           answer <- list(i=i, j=j)
         },
         ijd = {
           answer <- list(i=i, j=j, d=d)
         })
  if(!is.null(iX) && !is.null(iY))
    answer <- remove.identical.pairs(answer, iX, iY)
  return(answer)
}

closethresh <- function(X, R, S, twice=TRUE, ...) {
  # list all R-close pairs
  # and indicate which of them are S-close (S < R)
  # so that results are consistent with closepairs(X,S)
  verifyclass(X, "ppp")
  stopifnot(is.numeric(R) && length(R) == 1L && R >= 0)
  stopifnot(is.numeric(S) && length(S) == 1L && S >= 0)
  stopifnot(S < R)
  ordered <- list(...)$ordered
  if(missing(twice) && !is.null(ordered)) {
    warning("Obsolete argument 'ordered' has been replaced by 'twice'")
    twice <- ordered
  }
  npts <- npoints(X)
   if(npts <= 1)
     return(list(i=integer(0), j=integer(0), t=logical(0)))
  # sort points by increasing x coordinate
  oo <- fave.order(X$x)
  Xsort <- X[oo]
  ## First make an OVERESTIMATE of the number of pairs
  npairs <- as.double(npts) * (as.double(npts) - 1)
  if(npairs <= 1024) {
    nsize <- 1024
  } else {
    catchfraction <- pi * (R^2)/area(Frame(X))
    nsize <- ceiling(4 * catchfraction * npairs)
    nsize <- min(nsize, npairs)
    nsize <- max(1024, nsize)
    if(nsize > .Machine$integer.max) {
      warning(
        "Estimated number of close pairs exceeds maximum possible integer",
        call.=FALSE)
      nsize <- .Machine$integer.max
    }
  }
  # Now extract pairs
  x <- Xsort$x
  y <- Xsort$y
  r <- R
  s <- S
  ng <- nsize
  storage.mode(x) <- "double"
  storage.mode(y) <- "double"
  storage.mode(r) <- "double"
  storage.mode(s) <- "double"
  storage.mode(ng) <- "integer"
  z <- .Call(SG_Vclosethresh,
             xx=x, yy=y, rr=r, ss=s, nguess=ng,
             PACKAGE="spatstat.geom")
  if(length(z) != 3)
    stop("Internal error: incorrect format returned from Vclosethresh")
  i  <- z[[1L]]  # NB no increment required
  j  <- z[[2L]]
  th <- as.logical(z[[3L]])
  
  # convert i,j indices to original sequence
  i <- oo[i]
  j <- oo[j]
  # fast C code only returns i < j
  if(twice) {
    iold <- i
    jold <- j
    i <- c(iold, jold)
    j <- c(jold, iold)
    th <- rep(th, 2)
  }
  # done
  return(list(i=i, j=j, th=th))
}

crosspairquad <- function(Q, rmax, what=c("all", "indices")) {
  # find all close pairs X[i], U[j]
  stopifnot(inherits(Q, "quad"))
  what <- match.arg(what)
  X <- Q$data
  D <- Q$dummy
  clX <- closepairs(X=X, rmax=rmax, what=what)
  clXD <- crosspairs(X=X, Y=D, rmax=rmax, what=what)
  # convert all indices to serial numbers in union.quad(Q)
  # assumes data are listed first
  clXD$j <- npoints(X) + clXD$j
  result <- as.list(rbind(as.data.frame(clX), as.data.frame(clXD)))
  return(result)
}

tweak.closepairs <- function(cl, rmax, i, deltax, deltay, deltaz) {
  stopifnot(is.list(cl))
  stopifnot(all(c("i", "j") %in% names(cl)))
  if(!any(c("xi", "dx") %in% names(cl)))
    stop("Insufficient data to update closepairs list")
  check.1.real(rmax)
  check.1.integer(i)
  check.1.real(deltax)
  check.1.real(deltay)
  if("dz" %in% names(cl)) check.1.real(deltaz) else { deltaz <- NULL }
  hit.i <- (cl$i == i)
  hit.j <- (cl$j == i)
  if(any(hit.i | hit.j)) {
    mm <- hit.i & !hit.j
    if(any(mm)) {
      cl$xi[mm] <- cl$xi[mm] + deltax
      cl$yi[mm] <- cl$yi[mm] + deltay
      cl$dx[mm] <- cl$dx[mm] - deltax
      cl$dy[mm] <- cl$dy[mm] - deltay
      if(is.null(deltaz)) {
        cl$d[mm] <- sqrt(cl$dx[mm]^2 + cl$dy[mm]^2)
      } else {
        cl$zi[mm] <- cl$zi[mm] + deltaz
        cl$dz[mm] <- cl$dz[mm] - deltaz
        cl$d[mm] <- sqrt(cl$dx[mm]^2 + cl$dy[mm]^2 + cl$dz[mm]^2)
      }
    }
    mm <- hit.j & !hit.i
    if(any(mm)) {
      cl$xj[mm] <- cl$xj[mm] + deltax
      cl$yj[mm] <- cl$yj[mm] + deltay
      cl$dx[mm] <- cl$dx[mm] + deltax
      cl$dy[mm] <- cl$dy[mm] + deltay
      if(is.null(deltaz)) {
        cl$d[mm] <- sqrt(cl$dx[mm]^2 + cl$dy[mm]^2)
      } else {
        cl$zj[mm] <- cl$zj[mm] + deltaz
        cl$dz[mm] <- cl$dz[mm] + deltaz
        cl$d[mm] <- sqrt(cl$dx[mm]^2 + cl$dy[mm]^2 + cl$dz[mm]^2)
      }
    }
    mm <- hit.i & hit.j
    if(any(mm)) {
      cl$xi[mm] <- cl$xi[mm] + deltax
      cl$xj[mm] <- cl$xj[mm] + deltax
      cl$yi[mm] <- cl$yi[mm] + deltay
      cl$yj[mm] <- cl$yj[mm] + deltay
      if(!is.null(deltaz)) {
        cl$zi[mm] <- cl$zi[mm] + deltaz
        cl$zj[mm] <- cl$zj[mm] + deltaz
      }
    }
    if(any(lost <- (cl$d > rmax)))
      cl <- as.list(as.data.frame(cl)[!lost, , drop=FALSE])
  }
  return(cl)
}

remove.identical.pairs <- function(cl, imap, jmap) {
  ## 'cl' is the result of crosspairs
  ## 'imap', 'jmap' map the 'i' and 'j' indices to a common sequence
  distinct <- (imap[cl$i] != jmap[cl$j])
  if(!all(distinct))
    cl <- lapply(cl, "[", i=distinct)
  return(cl)
}
