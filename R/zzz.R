
#' @useDynLib drewcurves, .registration = TRUE 
#' @importFrom Rcpp evalCpp
NULL

.onUnload <- function (libpath) {
  library.dynam.unload("drewcurves", libpath)
}

# ## Uncomment the next line and run it every time a C++ function is added
# tools::package_native_routine_registration_skeleton(".", "src/init.c")
