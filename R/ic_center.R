#' Information-Dense Centroid
#'
#' Calculates the entropy-weighted center of a numeric vector.
#' @param x A numeric vector.
#' @param method Density estimation method.
#' @param alpha Power parameter for weights.
#' @param ... Additional arguments passed to density().
#' @return A single numeric value.
#' @export
#' @examples
#' x <- c(rnorm(90, 0, 0.5), rnorm(10, 10, 2))
#' ic_center(x, method = "kde")
ic_center <- function(x, method = c("hist", "kde"), alpha = NULL, ...) {
  g <- ic_weights(x, method, alpha, ...)
  sum(g$values * g$weights)
}
