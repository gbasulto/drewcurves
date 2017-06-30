
#' @useDynLib drewcurves, .registration = TRUE 
#' @importFrom Rcpp evalCpp
NULL

.onUnload <- function (libpath) {
  library.dynam.unload("drewcurves", libpath)
}