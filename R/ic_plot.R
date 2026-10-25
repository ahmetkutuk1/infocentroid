#' Plot Information-Dense Centroid
#'
#' Creates a futuristic, dark-themed plot comparing the classical mean with the IDC.
#' @param x A numeric vector.
#' @param method Density estimation method.
#' @param alpha Power parameter for weights.
#' @param ... Additional arguments passed to density().
#' @return A ggplot object.
#' @export
ic_plot <- function(x, method = c("hist", "kde"), alpha = NULL, ...) {
  if (!requireNamespace("ggplot2", quietly = TRUE)) stop("Package 'ggplot2' is required.")
  if (!requireNamespace("ggfx", quietly = TRUE)) stop("Package 'ggfx' is required.")

  method <- match.arg(method)

  # Calculate weights and centers
  g <- ic_weights(x, method, alpha, ...)
  ic_c <- ic_center(x, method, alpha, ...)
  class_mean <- mean(x)

  # Data frame for the plot
  df <- data.frame(values = g$values, weights = g$weights)

  # Premium Professional Plot
  p <- ggplot2::ggplot(df, ggplot2::aes(x = values)) +
    # Main density area (subtle glow, elegant color)
    ggfx::with_outer_glow(
      ggplot2::geom_area(ggplot2::aes(y = weights), fill = "#20B2AA", alpha = 0.7),
      colour = "#20B2AA", sigma = 5
    ) +
    # Classical Mean (Red dashed line)
    ggplot2::geom_vline(xintercept = class_mean, color = "#E74C3C", linetype = "dashed", linewidth = 1) +
    # IDC (Green solid line)
    ggplot2::geom_vline(xintercept = ic_c, color = "#2ECC71", linewidth = 1.2) +
    # Professional Dark Theme
    ggplot2::theme_minimal() +
    ggplot2::theme(
      plot.background = ggplot2::element_rect(fill = "#1E2229", color = NA),
      panel.background = ggplot2::element_rect(fill = "#1E2229", color = NA),
      panel.grid.major = ggplot2::element_line(color = "#34495E", linewidth = 0.3),
      panel.grid.minor = ggplot2::element_blank(),
      text = ggplot2::element_text(color = "#BDC3C7"),
      axis.text = ggplot2::element_text(color = "#95A5A6"),
      plot.title = ggplot2::element_text(color = "#FFFFFF", face = "bold", size = 14),
      plot.subtitle = ggplot2::element_text(color = "#95A5A6", size = 10)
    ) +
    ggplot2::labs(
      title = "Information-Dense Centroid Analysis",
      subtitle = paste0("Red dashed: Classical Mean (", round(class_mean, 2),
                        ") | Green solid: IDC (", round(ic_c, 2), ")"),
      x = "Values", y = "Information Weight"
    )

  return(p)
}
