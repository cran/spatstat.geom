
/* 
   Native symbol registration table for spatstat.geom package

   Automatically generated - do not edit this file!

*/

#include "proto.h"
#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/*  
   See proto.h for declarations for the native routines registered below.
*/

static const R_CMethodDef CEntries[] = {
    {"anydupxy",          (DL_FUNC) &anydupxy,           4},
    {"areaBdif",          (DL_FUNC) &areaBdif,          11},
    {"areadifs",          (DL_FUNC) &areadifs,           7},
    {"auctionbf",         (DL_FUNC) &auctionbf,          7},
    {"bdrymask",          (DL_FUNC) &bdrymask,           4},
    {"Ccrossdist",        (DL_FUNC) &Ccrossdist,         8},
    {"CcrossPdist",       (DL_FUNC) &CcrossPdist,       10},
    {"coco4dbl",          (DL_FUNC) &coco4dbl,           3},
    {"coco4int",          (DL_FUNC) &coco4int,           3},
    {"coco8dbl",          (DL_FUNC) &coco8dbl,           3},
    {"coco8int",          (DL_FUNC) &coco8int,           3},
    {"cocoGraph",         (DL_FUNC) &cocoGraph,          6},
    {"Corput",            (DL_FUNC) &Corput,             3},
    {"Cpairdist",         (DL_FUNC) &Cpairdist,          5},
    {"CpairPdist",        (DL_FUNC) &CpairPdist,         7},
    {"crosscount",        (DL_FUNC) &crosscount,         8},
    {"Cxypolyselfint",    (DL_FUNC) &Cxypolyselfint,    11},
    {"D3crossdist",       (DL_FUNC) &D3crossdist,       10},
    {"D3crossPdist",      (DL_FUNC) &D3crossPdist,      13},
    {"D3pairdist",        (DL_FUNC) &D3pairdist,         6},
    {"D3pairPdist",       (DL_FUNC) &D3pairPdist,        9},
    {"Ddist2dpath",       (DL_FUNC) &Ddist2dpath,        7},
    {"dinfty_R",          (DL_FUNC) &dinfty_R,           3},
    {"discareapoly",      (DL_FUNC) &discareapoly,      12},
    {"discs2grid",        (DL_FUNC) &discs2grid,        11},
    {"distmapbin",        (DL_FUNC) &distmapbin,        10},
    {"dwpure",            (DL_FUNC) &dwpure,             6},
    {"exact_dt_R",        (DL_FUNC) &exact_dt_R,        14},
    {"fardist2grid",      (DL_FUNC) &fardist2grid,      10},
    {"fardistgrid",       (DL_FUNC) &fardistgrid,       10},
    {"Fclosepairs",       (DL_FUNC) &Fclosepairs,       16},
    {"Fcrosspairs",       (DL_FUNC) &Fcrosspairs,       19},
    {"hasX3close",        (DL_FUNC) &hasX3close,         6},
    {"hasX3pclose",       (DL_FUNC) &hasX3pclose,        7},
    {"hasXclose",         (DL_FUNC) &hasXclose,          5},
    {"hasXpclose",        (DL_FUNC) &hasXpclose,         6},
    {"hasXY3close",       (DL_FUNC) &hasXY3close,       10},
    {"hasXY3pclose",      (DL_FUNC) &hasXY3pclose,      11},
    {"hasXYclose",        (DL_FUNC) &hasXYclose,         8},
    {"hasXYpclose",       (DL_FUNC) &hasXYpclose,        9},
    {"hotrodAbsorb",      (DL_FUNC) &hotrodAbsorb,       7},
    {"hotrodInsul",       (DL_FUNC) &hotrodInsul,        7},
    {"Idist2dpath",       (DL_FUNC) &Idist2dpath,        7},
    {"knnd3D",            (DL_FUNC) &knnd3D,             8},
    {"knndMD",            (DL_FUNC) &knndMD,             6},
    {"knndsort",          (DL_FUNC) &knndsort,           6},
    {"knnGinterface",     (DL_FUNC) &knnGinterface,     15},
    {"knnw3D",            (DL_FUNC) &knnw3D,             8},
    {"knnwhich",          (DL_FUNC) &knnwhich,           6},
    {"knnwMD",            (DL_FUNC) &knnwMD,             7},
    {"knnX3Dinterface",   (DL_FUNC) &knnX3Dinterface,   17},
    {"knnXinterface",     (DL_FUNC) &knnXinterface,     15},
    {"knnXwMD",           (DL_FUNC) &knnXwMD,            9},
    {"knnXxMD",           (DL_FUNC) &knnXxMD,           11},
    {"maxnnd2",           (DL_FUNC) &maxnnd2,            5},
    {"maxPnnd2",          (DL_FUNC) &maxPnnd2,           5},
    {"mdtPconv",          (DL_FUNC) &mdtPconv,          16},
    {"mdtPOrect",         (DL_FUNC) &mdtPOrect,         14},
    {"minnnd2",           (DL_FUNC) &minnnd2,            5},
    {"minPnnd2",          (DL_FUNC) &minPnnd2,           5},
    {"nearestvalidpixel", (DL_FUNC) &nearestvalidpixel, 10},
    {"nnd3D",             (DL_FUNC) &nnd3D,              7},
    {"nndistsort",        (DL_FUNC) &nndistsort,         5},
    {"nndMD",             (DL_FUNC) &nndMD,              5},
    {"nnGinterface",      (DL_FUNC) &nnGinterface,      14},
    {"nnw3D",             (DL_FUNC) &nnw3D,              7},
    {"nnwhichsort",       (DL_FUNC) &nnwhichsort,        5},
    {"nnwMD",             (DL_FUNC) &nnwMD,              6},
    {"nnX3Dinterface",    (DL_FUNC) &nnX3Dinterface,    16},
    {"nnXinterface",      (DL_FUNC) &nnXinterface,      14},
    {"nnXwMD",            (DL_FUNC) &nnXwMD,             8},
    {"nnXxMD",            (DL_FUNC) &nnXxMD,            10},
    {"paircount",         (DL_FUNC) &paircount,          5},
    {"poly2imA",          (DL_FUNC) &poly2imA,           7},
    {"poly2imI",          (DL_FUNC) &poly2imI,           6},
    {"ps_exact_dt_R",     (DL_FUNC) &ps_exact_dt_R,     13},
    {"raster3filter",     (DL_FUNC) &raster3filter,      5},
    {"seg2pixI",          (DL_FUNC) &seg2pixI,           8},
    {"seg2pixL",          (DL_FUNC) &seg2pixL,          11},
    {"seg2pixN",          (DL_FUNC) &seg2pixN,           9},
    {"tabsumweight",      (DL_FUNC) &tabsumweight,       6},
    {"trigraf",           (DL_FUNC) &trigraf,           10},
    {"trigrafS",          (DL_FUNC) &trigrafS,          10},
    {"uniqmap2M",         (DL_FUNC) &uniqmap2M,          5},
    {"uniqmapxy",         (DL_FUNC) &uniqmapxy,          4},
    {"xypsi",             (DL_FUNC) &xypsi,             10},
    {"xysegint",          (DL_FUNC) &xysegint,          16},
    {"xysegXint",         (DL_FUNC) &xysegXint,         11},
    {"xysi",              (DL_FUNC) &xysi,              12},
    {"xysiANY",           (DL_FUNC) &xysiANY,           12},
    {"xysxi",             (DL_FUNC) &xysxi,              7},
    {NULL, NULL, 0}
};

static const R_CallMethodDef CallEntries[] = {
    {"altVcloseIJDpairs", (DL_FUNC) &altVcloseIJDpairs, 4},
    {"altVcloseIJpairs",  (DL_FUNC) &altVcloseIJpairs,  4},
    {"altVclosepairs",    (DL_FUNC) &altVclosepairs,    4},
    {"close3IJDpairs",    (DL_FUNC) &close3IJDpairs,    5},
    {"close3IJpairs",     (DL_FUNC) &close3IJpairs,     5},
    {"close3pairs",       (DL_FUNC) &close3pairs,       5},
    {"closePpair",        (DL_FUNC) &closePpair,        5},
    {"cross3IJDpairs",    (DL_FUNC) &cross3IJDpairs,    8},
    {"cross3IJpairs",     (DL_FUNC) &cross3IJpairs,     8},
    {"cross3pairs",       (DL_FUNC) &cross3pairs,       8},
    {"crossPpair",        (DL_FUNC) &crossPpair,        7},
    {"Cwhist",            (DL_FUNC) &Cwhist,            3},
    {"Cxysegint",         (DL_FUNC) &Cxysegint,         9},
    {"CxysegXint",        (DL_FUNC) &CxysegXint,        5},
    {"graphVees",         (DL_FUNC) &graphVees,         3},
    {"triDgraph",         (DL_FUNC) &triDgraph,         4},
    {"triDRgraph",        (DL_FUNC) &triDRgraph,        5},
    {"trigraph",          (DL_FUNC) &trigraph,          3},
    {"triograph",         (DL_FUNC) &triograph,         3},
    {"trioxgraph",        (DL_FUNC) &trioxgraph,        4},
    {"VcloseIJDpairs",    (DL_FUNC) &VcloseIJDpairs,    4},
    {"VcloseIJpairs",     (DL_FUNC) &VcloseIJpairs,     4},
    {"Vclosepairs",       (DL_FUNC) &Vclosepairs,       4},
    {"Vclosethresh",      (DL_FUNC) &Vclosethresh,      5},
    {"VcrossIJDpairs",    (DL_FUNC) &VcrossIJDpairs,    6},
    {"VcrossIJpairs",     (DL_FUNC) &VcrossIJpairs,     6},
    {"Vcrosspairs",       (DL_FUNC) &Vcrosspairs,       6},
    {NULL, NULL, 0}
};

void R_init_spatstat_geom(DllInfo *dll)
{
    R_registerRoutines(dll, CEntries, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
    R_forceSymbols(dll, TRUE); 
}
