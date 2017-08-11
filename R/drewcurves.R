##' Andrews Plot
##'
##' This function computes the Andrews plot of a dataframe.
##'
##' The default output is the Andrews plot generated with ggplot2. 
##' @param df
##' @param type
##' @param group
##' @param resolution
##' @param return_dataframe
##' @param minmax_scaling
##' @param xlim
##' @return
##' @author Guillermo Basulto-Elias
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
    if (minmax_scaling) df <- drewcurves:::minmax(df)

    ## Compute Fourier Series
    t <- seq(xlim[1], xlim[2], length.out = resolution)
    fourier_series <- compute_fourier_series(df, t = t, type = type)
    

    out <-
        fourier_series %>%
        as.data.frame() %>%
        mutate(t = t) %>%
        gather(key, value, -t) %>%
        mutate(group = rep(grp, each = resolution)) %>%
        ggplot(aes(t, value, group = key)) + 
        geom_line(aes(color = group))
    
    out
}
