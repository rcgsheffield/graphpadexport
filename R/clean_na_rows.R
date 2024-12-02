#' Remove rows where all values are NA
#'
#' This function removes rows from a data frame where all the values are missing (NA).
#' It is useful for cleaning data by eliminating rows that contain only missing values.
#'
#' @param df A data frame. The function will remove rows where all values are NA.
#'
#' @return A data frame with rows where all values are NA removed.
#'
#' @examples
#' # Example: Remove rows with all NA values from a data frame
#' df <- data.frame(a = c(1, 2, NA), b = c(NA, 4, 5))
#' clean_na_rows(df)
#'
#' @export
clean_na_rows <- function(df) {
  # Check if input is a data frame
  if (!is.data.frame(df)) stop("Input must be a data frame")

  # Filter out rows where all values are NA
  df <- df[rowSums(!is.na(df)) > 0, ]

  return(df)
}
