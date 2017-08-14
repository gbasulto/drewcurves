##' Andrews Plot
##'
##' This function computes the Andrews plot of a dataframe.
##'
##' The default output is the Andrews plot generated with ggplot2.
##' @param df An nxp dataframe or matrix.
##' @param type Type of Fourier series to be computed. See vignette.
##' @param group Integer indicating the number of column that
##'     represents the group, if any.
##' @param resolution The number of regularly spaced points where the
##'     Fourier series will be evaluated.
##' @param return_dataframe If TRUE, the function will return the
##'     dataframe used to generate the Andrews plot rather than the
##'     plot itself.
##' @param minmax_scaling If TRUE, it substract the mimimum and divide
##'     by the length of the range of every column.
##' @param xlim A vector of size two with the limits where the Fourier
##'     series will be evaluated. The default limits are are -pi and
##'     pi.
##' @return A ggplot object or a dataframe (depending on the parameter
##'     'return_dataframe').
##' @author Guillermo Basulto-Elias
##' @export 
drewcurves <- function (df, type = 1, group = NULL, resolution = 100,
                        return_dataframe = FALSE,
                        minmax_scaling = TRUE, xlim = c(-pi, pi)) {

    ## Extract column names
    var_names <- colnames(df)

    ## Remove group variable if it is provided
    if (!is.null(group)) {
        grp <- df[, group]
        df <- df[, -group]
    }

    ## Convert the rest of the variables to 
    df <- as.matrix(df)
    print(head(df))

    ## Scale if required.
    if (minmax_scaling) df <- minmax(df)

    ## Compute Fourier Series
    t <- seq(xlim[1], xlim[2], length.out = resolution)
    fourier_series <- compute_fourier_series(df, t = t, type = type)
    

    ## Create 'long format' dataframe with no group (at this point).
    out <-
        fourier_series %>%
        as.data.frame() %>%
        mutate(t = t) %>%
        gather(key, value, -t)

    ## Add group if it exists.
    out <- out %>%
        mutate(group = rep(grp, each = resolution))

    out <- out %>%
        ggplot(aes(t, value, group = key)) + 
        geom_line(aes(color = group))
    
    out
}