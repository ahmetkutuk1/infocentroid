#' Summary of Information-Dense Centroid
#'
#' Prints a comprehensive summary of classical and IC metrics, and optionally generates the plot.
#' @param x A numeric vector.
#' @param method Density estimation method.
#' @param alpha Power parameter for weights.
#' @param plot Logical. Whether to display the plot. Default is TRUE.
#' @param ... Additional arguments passed to density().
#' @return Prints summary to console and returns the plot invisibly.
#' @export
ic_summary <- function(x, method = c("hist", "kde"), alpha = NULL, plot = TRUE, ...) {
  method <- match.arg(method)

  # Calculate all metrics
  comp <- ic_combined(x, method, alpha, ...)

  # Print a nice summary to console
  cat("\n========================================\n")
  cat("   INFORMATION-DENSE CENTROID SUMMARY   \n")
  cat("========================================\n")
  cat(sprintf("Classical Mean        : %8.3f\n", mean(x)))
  cat(sprintf("Classical SD          : %8.3f\n", sd(x)))
  cat("----------------------------------------\n")
  cat(sprintf("IC Center (IDC)       : %8.3f\n", comp$center))
  cat(sprintf("IC Dispersion         : %8.3f\n", comp$dispersion))
  cat(sprintf("Sharpness (Entropy)   : %8.3f\n", comp$entropy_score))
  cat(sprintf("Density Score (Comb.) : %8.3f\n", comp$combined_score))
  cat("========================================\n\n")

  # Plot the futuristic visual if requested
  if (plot) {
    print(ic_plot(x, method = method, alpha = alpha, ...))
  }
}
