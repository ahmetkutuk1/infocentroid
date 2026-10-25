#' Information-Dense Dispersion
#'
#' Calculates the dispersion based on the same entropy-weighted distribution used in ic_center.
#' @param x A numeric vector.
#' @param method Density estimation method.
#' @param alpha Power parameter for weights.
#' @param ... Additional arguments passed to density().
#' @return A numeric value representing dispersion.
#' @export
ic_dispersion <- function(x, method = c("hist", "kde"), alpha = NULL, ...) {
  g <- ic_weights(x, method, alpha, ...)
  center <- sum(g$values * g$weights)
  sqrt(sum(g$weights * (g$values - center)^2))
}
