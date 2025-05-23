% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clean_na_rows.R
\name{clean_na_rows}
\alias{clean_na_rows}
\title{Remove rows where all values are NA}
\usage{
clean_na_rows(df)
}
\arguments{
\item{df}{A data frame. The function will remove rows where all values are NA.}
}
\value{
A data frame with rows where all values are NA removed.
}
\description{
This function removes rows from a data frame where all the values are missing (NA).
It is useful for cleaning data by eliminating rows that contain only missing values.
}
\examples{
# Example: Remove rows with all NA values from a data frame
df <- data.frame(a = c(1, 2, NA), b = c(NA, 4, 5))
clean_na_rows(df)

}
