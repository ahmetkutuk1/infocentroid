# infocentroid

**Information-Dense Centroid Metrics for R**

The `infocentroid` package provides a novel, information-theoretic approach to measuring central tendency and dispersion. Unlike classical statistics (Mean and Standard Deviation), which can be misled by outliers and multimodal distributions, `infocentroid` weights observations based on their information density.

## Installation

You can install the development version from GitHub. Open your R console and run the following command:

devtools::install_github("ahmetkutuk1/infocentroid")

## The Problem with Classical Means

Consider a bimodal distribution where 90% of the data is concentrated at 0, and 10% at 10. The classical mean falls right in the middle (around 1), pointing to a region with zero data density. The Information-Dense Centroid (IDC), however, correctly identifies the true mass of the data.

## Core Functions

- **ic_center()**: Calculates the entropy-weighted center.
- **ic_dispersion()**: Calculates the information-weighted dispersion.
- **ic_combined()**: Combines sharpness and signal-to-noise ratio into a single score (0 to 1).
- **ic_plot()**: Generates a futuristic, dark-themed visualization comparing classical and IC metrics.
- **ic_summary()**: Provides a full console summary and plot.

## Example

To see the package in action, run this code in your R console:

library(infocentroid)

set.seed(42)

x <- c(rnorm(90, 0, 0.5), rnorm(10, 10, 2))

ic_summary(x, method = "kde")
