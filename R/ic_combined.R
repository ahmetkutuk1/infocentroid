#' Information Density Score
#'
#' Combines sharpness (inverse entropy) and signal-to-noise ratio (SNR) into a single score between 0 and 1.
#' @param x A numeric vector.
#' @param method Density estimation method.
#' @param alpha Power parameter for weights.
#' @param ... Additional arguments passed to density().
#' @return A list containing the combined score and sub-components.
#' @export
ic_combined <- function(x, method = c("hist", "kde"), alpha = NULL, ...) {
  method <- match.arg(method)
  x <- x[is.finite(x)]
  if (length(x) < 3) stop("At least 3 finite observations required")

  # Calculate sub-components
  disp <- ic_dispersion(x, method, alpha, ...)
  g <- ic_weights(x, method, alpha, ...)
  center_val <- ic_center(x, method, alpha, ...)

  H <- g$entropy
  H_max <- g$H_max

  # 1. Sharpness (Inverse of entropy)
  entropy_score <- if (H_max > 0) 1 - (H / H_max) else 1

  # 2. Signal-to-Noise Ratio
  snr <- 1 / (1 + disp)

  # Final Information Density Score
  combined_score <- sqrt(entropy_score * snr)

  # Return results as a list
  list(
    combined_score = combined_score,
    center = center_val,
    dispersion = disp,
    entropy_score = entropy_score,
    snr = snr,
    alpha = g$alpha
  )
}
