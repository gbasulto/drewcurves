
#' @useDynLib drewcurves
#' @importFrom Rcpp sourceCpp
NULL

.onUnload <- function (libpath) {
  library.dynam.unload("drewcurves", libpath)
}