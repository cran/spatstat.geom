#
#	exactPdt.R
#	R function exactPdt() for exact distance transform of binary mask
#
#	$Revision: 4.23 $	$Date: 2022/05/21 09:52:11 $
#

"exactPdt"<-
  function(w)
{
  verifyclass(w, "owin")
  if(w$type != "mask")
    stop(paste("Input must be a window of type", sQuote("mask")))
  ##	
  nr <- w$dim[1L]
  nc <- w$dim[2L]
  xcol <- w$xcol
  yrow <- w$yrow
  ## handle empty window
  if(!any(w$m)) {
    dist <- matrix(Inf, nr, nc)
    rows <- cols <- matrix(NA_integer_ , nr, nc)
    bdist <- framedist.pixels(w, style="matrix")
    return(list(d=dist,row=rows,col=cols,b=bdist, w=w))
  }
# input image will be padded out with a margin of width 2 on all sides
  mr <- mc <- 2L
  # full dimensions of padded image
  Nnr <- nr + 2 * mr
  Nnc <- nc + 2 * mc
  N <- Nnr * Nnc
  # output image (subset): rows & columns (R indexing)
  rmin <- mr + 1L
  rmax <- Nnr - mr
  cmin <- mc + 1L
  cmax <- Nnc - mc
  ## do padding
  x <- matrix(FALSE, nrow=Nnr, ncol=Nnc)
  x[rmin:rmax, cmin:cmax] <- w$m
  res <- .C(SG_ps_exact_dt_R,
            as.double(xcol[1L]),
            as.double(yrow[1L]),
            as.double(xcol[nc]),
            as.double(yrow[nr]),
            nr = as.integer(nr),
            nc = as.integer(nc),
            mr = as.integer(mr),
            mc = as.integer(mc),
            inp = as.integer(t(x)),
            distances = as.double (double(N)),
            rows      = as.integer(integer(N)),
            cols      = as.integer(integer(N)),
            boundary  = as.double (double(N)),
            PACKAGE="spatstat.geom")
  dist <- matrix(res$distances,
                 ncol=Nnc, nrow=Nnr, byrow = TRUE)[rmin:rmax, cmin:cmax]
  rows <- matrix(res$rows,
                 ncol=Nnc, nrow=Nnr, byrow = TRUE)[rmin:rmax, cmin:cmax]
  cols <- matrix(res$cols,
                 ncol=Nnc, nrow=Nnr, byrow = TRUE)[rmin:rmax, cmin:cmax]
  bdist<- matrix(res$boundary,
                 ncol=Nnc, nrow=Nnr, byrow = TRUE)[rmin:rmax, cmin:cmax]
  # convert from C to R indexing
  rows <- rows + 1L - as.integer(mr)
  cols <- cols + 1L - as.integer(mc)
  return(list(d=dist,row=rows,col=cols,b=bdist, w=w))
}

project2set <- function(X, W, ...) {
  stopifnot(is.ppp(X))
  W <- as.mask(W, ...)
  eW <- exactPdt(W)
  ## grid location of X
  XX <- nearest.raster.point(X$x, X$y, W)
  ijX <- cbind(XX$row, XX$col)
  ## look up values of 'eW' at this location 
  iY <- eW$row[ijX]
  jY <- eW$col[ijX]
  ## convert to spatial coordinates
  Y <- ppp(W$xcol[jY], W$yrow[iY], window=W)
  return(Y)
}
