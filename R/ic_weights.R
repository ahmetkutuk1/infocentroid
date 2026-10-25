#' Internal Weights Calculation
#'
#' Computes the entropy-weighted distribution used by the IC metrics.
#' @param x A numeric vector.
#' @param method Density estimation method.
#' @param alpha Power parameter for weights.
#' @param ... Additional arguments passed to density().
#' @return A list of values, weights, entropy, and alpha.
#' @export
ic_weights <- function(x, method = c("hist", "kde"), alpha = NULL, ...) {
  method <- match.arg(method)
  if (!is.numeric(x)) stop("`x` must be numeric")
  x <- x[is.finite(x)]
  if (length(x) < 3) stop("At least 3 finite observations required")

  if (method == "hist") {
    h <- hist(x, breaks = "Sturges", plot = FALSE)
    p    <- h$counts / sum(h$counts)
    vals <- h$mids
  } else {
    d <- density(x, ...)
    p    <- d$y / sum(d$y)
    vals <- d$x
  }

  keep <- p > 0
  p <- p[keep]; vals <- vals[keep]

  H     <- -sum(p * log(p))
  H_max <- log(length(p))
  if (is.null(alpha)) alpha <- 1 + (1 - H / H_max)

  w <- p^alpha
  w <- w / sum(w)   # normalize once, downstream simpler

  list(values = vals, p = p, weights = w,
       alpha = alpha, entropy = H, H_max = H_max)
}
