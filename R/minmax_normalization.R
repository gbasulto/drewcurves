
##' Min-max Normalization
##'
##' Normalize columns by substracting its minimum and dividing by the
##' length of its range. The resulting columns will be between zero
##' and one. It does not affect non-numeric columns.
##' @param X Vector, matriz or dataframe. 
##' @return An object of the same type and dimensions as X.
##' @examples
##' data(iris)
##' minmax_normalization(iris[, -5])
##' @author Guillermo Basulto-Elias
##' @export
minmax_normalization <- function (X) {

    ## Normalize vector
    if (is.vector(X)) {
        ## If the vector is not numeric, it does nothing.
        if (is.numeric(X)) return (X)
        min_X <- min(X)
        range <- max(X) - min_X
        return ((X - min_X)/range)
    }
    
    ## Normalize matrix or dataframe by column
    apply(X, 2, minmax_normalization)
}


