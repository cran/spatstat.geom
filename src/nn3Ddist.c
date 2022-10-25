/*

  nn3Ddist.c

  Nearest Neighbour Distances in 3D 

  $Revision: 1.15 $     $Date: 2022/10/22 09:29:51 $

  Copyright (C) Adrian Baddeley, Ege Rubak and Rolf Turner 2001-2018
  Licence: GNU Public Licence >= 2

  THE FOLLOWING FUNCTIONS ASSUME THAT z IS SORTED IN ASCENDING ORDER 

  nnd3D     Nearest neighbour distances 
  nnw3D     Nearest neighbours (id)
  nndw3D     Nearest neighbours (id) and distances

  nnXdw3D    Nearest neighbour from one list to another
  nnXEdw3D    Nearest neighbour from one list to another, with overlaps

  knnd3D    k-th nearest neighbour distances
  knnw3D    k-th nearest neighbours (id)
  knndw3D    k-th nearest neighbours (id) and distances
*/

#undef SPATSTAT_DEBUG

#include <R.h>
#include <R_ext/Utils.h>
#include <math.h>
#include "chunkloop.h"

#include "yesno.h"

double sqrt(double x);

/* >>>>>>>>>>>> NEAREST NEIGHBOURS <<<<<<<<<<<<<<<<<<<<<<<< */

/* .......... Single point pattern ...............................*/

#undef FNAME
#undef DIST
#undef WHICH

/* nnd3D: returns nn distance */

#define FNAME nnd3D
#define DIST
#include "nn3Ddist.h"
#undef FNAME
#undef DIST
#undef WHICH

/* nnw3D: returns id of nearest neighbour */

#define FNAME nnw3D
#define WHICH
#include "nn3Ddist.h"
#undef FNAME
#undef DIST
#undef WHICH

/* nndw3D: returns nn distance .and. id of nearest neighbour */

#define FNAME nndw3D
#define DIST
#define WHICH
#include "nn3Ddist.h"
#undef FNAME
#undef DIST
#undef WHICH


/* .......... Two point patterns ...............................*/

/* 
   nnXdw3D:  for TWO point patterns X and Y,
   find the nearest neighbour 
   (from each point of X to the nearest point of Y)
   returning both the distance and the identifier

   Requires both patterns to be sorted in order of increasing z coord
*/

#define FNAME nnXdw3D
#define DIST
#define WHICH
#undef EXCLUDE
#include "nn3DdistX.h"
#undef FNAME
#undef DIST
#undef WHICH
#undef EXCLUDE

/* 
   nnXd3D:  returns distance only

*/

#define FNAME nnXd3D
#define DIST
#undef EXCLUDE
#include "nn3DdistX.h"
#undef FNAME
#undef DIST
#undef WHICH
#undef EXCLUDE

/* 
   nnXw3D:  returns identifier only
*/

#define FNAME nnXw3D
#define WHICH
#undef EXCLUDE
#include "nn3DdistX.h"
#undef FNAME
#undef DIST
#undef WHICH
#undef EXCLUDE

/* .......... Two point patterns with exclusion ........................*/

/* 
   nnXEdw3D:  similar to nnXdw3D
   but allows X and Y to include common points
   (which are not to be counted as neighbours)

   Code numbers id1, id2 are attached to the patterns X and Y respectively, 
   such that
   x1[i], y1[i] and x2[j], y2[j] are the same point iff id1[i] = id2[j].

   Requires both patterns to be sorted in order of increasing z coord
*/

#define FNAME nnXEdw3D
#define DIST
#define WHICH
#define EXCLUDE
#include "nn3DdistX.h"
#undef FNAME
#undef DIST
#undef WHICH
#undef EXCLUDE

/* 
   nnXEd3D:  returns distances only

*/

#define FNAME nnXEd3D
#define DIST
#define EXCLUDE
#include "nn3DdistX.h"
#undef FNAME
#undef DIST
#undef WHICH
#undef EXCLUDE

/* 
   nnXEw3D:  returns identifiers only

*/

#define FNAME nnXEw3D
#define WHICH
#define EXCLUDE
#include "nn3DdistX.h"
#undef FNAME
#undef DIST
#undef WHICH
#undef EXCLUDE

/* COMMON INTERFACE */
/* common interface for nearest neighbours of two point patterns */

void nnX3Dinterface(
  /* inputs */
  int *n1, double *x1, double *y1, double *z1, int *id1,
  int *n2, double *x2, double *y2, double *z2, int *id2,
  /* options */
  int *exclude,
  int *wantdist,
  int *wantwhich,
  /* outputs */
  double *nnd,
  int *nnwhich,
  /* upper bound on pairwise distance */
  double *huge
) {
  int ex, di, wh;
  ex = (*exclude != 0);
  di = (*wantdist != 0);
  wh = (*wantwhich != 0);
  if(!ex) {
    if(di && wh) {
      nnXdw3D(n1, x1, y1, z1, id1, n2, x2, y2, z2, id2, nnd, nnwhich, huge);
    } else if(di) {
      nnXd3D(n1, x1, y1, z1, id1, n2, x2, y2, z2, id2, nnd, nnwhich, huge);
    } else if(wh) {
      nnXw3D(n1, x1, y1, z1, id1, n2, x2, y2, z2, id2, nnd, nnwhich, huge);
    } 
  } else {
    if(di && wh) {
      nnXEdw3D(n1, x1, y1, z1, id1, n2, x2, y2, z2, id2, nnd, nnwhich, huge);
    } else if(di) {
      nnXEd3D(n1, x1, y1, z1, id1, n2, x2, y2, z2, id2, nnd, nnwhich, huge);
    } else if(wh) {
      nnXEw3D(n1, x1, y1, z1, id1, n2, x2, y2, z2, id2, nnd, nnwhich, huge);
    } 
  }
}

/* >>>>>>>>>>>>>> K-th NEAREST NEIGHBOURS <<<<<<<<<<<<<<<<<<<<< */

/* .......... Single point pattern ...............................*/
/* .......... k-th nearest neighbours ...............................*/

/* 
   knnd3D

   nearest neighbour distances 1:kmax

*/

#define FNAME knnd3D
#define DIST
#include "knn3Ddist.h"
#undef FNAME
#undef DIST
#undef WHICH

/* 
   knnw3D

   nearest neighbour indices 1:kmax

*/

#define FNAME knnw3D
#define WHICH
#include "knn3Ddist.h"
#undef FNAME
#undef DIST
#undef WHICH

/* 
   knndw3D

   nearest neighbours 1:kmax

   returns distances and indices

*/

#define FNAME knndw3D
#define DIST
#define WHICH
#include "knn3Ddist.h"
#undef FNAME
#undef DIST
#undef WHICH

/* .......... Two point patterns ...............................*/
/* .......... k-th nearest neighbours ...............................*/

#undef FNAME
#undef DIST
#undef WHICH
#undef EXCLUDE

/* 
   knnXdw3D

   nearest neighbours 1:kmax between two point patterns

   returns distances and indices

*/

#define FNAME knnXdw3D
#define DIST
#define WHICH
#include "knn3DdistX.h"
#undef FNAME
#undef DIST
#undef WHICH
#undef EXCLUDE

/* 
   knnXd3D

   nearest neighbours 1:kmax between two point patterns

   returns distances

*/

#define FNAME knnXd3D
#define DIST
#include "knn3DdistX.h"
#undef FNAME
#undef DIST
#undef WHICH
#undef EXCLUDE

/* 
   knnXw3D

   nearest neighbours 1:kmax between two point patterns

   returns indices

*/

#define FNAME knnXw3D
#define WHICH
#include "knn3DdistX.h"
#undef FNAME
#undef DIST
#undef WHICH
#undef EXCLUDE

/* .......... Two point patterns with exclusion ..........................*/
/* .......... k-th nearest neighbours ...............................*/

/* 
   knnXEdw3D

   nearest neighbours 1:kmax between two point patterns with exclusion

   returns distances and indices

*/

#define FNAME knnXEdw3D
#define DIST
#define WHICH
#define EXCLUDE
#include "knn3DdistX.h"
#undef FNAME
#undef DIST
#undef WHICH
#undef EXCLUDE

/* 
   knnXEd3D

   nearest neighbours 1:kmax between two point patterns with exclusion

   returns distances

*/

#define FNAME knnXEd3D
#define DIST
#define EXCLUDE
#include "knn3DdistX.h"
#undef FNAME
#undef DIST
#undef WHICH
#undef EXCLUDE

/* 
   knnXEw3D

   nearest neighbours 1:kmax between two point patterns with exclusion

   returns indices

*/

#define FNAME knnXEw3D
#define WHICH
#define EXCLUDE
#include "knn3DdistX.h"
#undef FNAME
#undef DIST
#undef WHICH
#undef EXCLUDE

/* GENERAL INTERFACE */
/* general interface for k-nearest neighbours of two point patterns */

void knnX3Dinterface(
     /* inputs */
  int *n1,  double *x1, double *y1, double *z1, int *id1, 
  int *n2,  double *x2, double *y2, double *z2, int *id2,
  int *kmax,
  /* options */
  int *exclude,
  int *wantdist,
  int *wantwhich,
  /* output matrices (n1 * kmax) in ROW MAJOR order */
  double *nnd,
  int *nnwhich,
  /* upper bound on pairwise distance */
  double *huge
  /* some inputs + outputs are not used in all functions */
) {
  int ex, di, wh;
  ex = (*exclude != 0);
  di = (*wantdist != 0);
  wh = (*wantwhich != 0);
  if(!ex) {
    if(di && wh) {
      knnXdw3D(n1,x1,y1,z1,id1,n2,x2,y2,z2,id2,kmax,nnd,nnwhich,huge);
    } else if(di) {
      knnXd3D(n1,x1,y1,z1,id1,n2,x2,y2,z2,id2,kmax,nnd,nnwhich,huge);
    } else if(wh) {
      knnXw3D(n1,x1,y1,z1,id1,n2,x2,y2,z2,id2,kmax,nnd,nnwhich,huge);
    } 
  } else {
    if(di && wh) {
      knnXEdw3D(n1,x1,y1,z1,id1,n2,x2,y2,z2,id2,kmax,nnd,nnwhich,huge);
    } else if(di) {
      knnXEd3D(n1,x1,y1,z1,id1,n2,x2,y2,z2,id2,kmax,nnd,nnwhich,huge);
    } else if(wh) {
      knnXEw3D(n1,x1,y1,z1,id1,n2,x2,y2,z2,id2,kmax,nnd,nnwhich,huge);
    } 
  }
}

