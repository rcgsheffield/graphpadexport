#' Convert .pzfx Files to CSV
#'
#' This function reads tables from a GraphPad Prism (.pzfx) file, cleans the data by removing rows with all NA values,
#' and saves each table as a separate CSV file. It provides a simple way to convert the data from GraphPad Prism
#' files into a more commonly used format like CSV for further analysis.
#'
#' @param file_path A character string specifying the path to the .pzfx file to be processed.
#'   It must point to a valid file on your system.
#' @param output_dir A character string specifying the directory where the CSV files should be saved.
#'   Defaults to the current working directory (`getwd()`).
#'
#' @return None. The function saves the extracted data as CSV files in the specified directory.
#'
#' @details
#' The function first lists all the tables in the given .pzfx file, extracts the data from each table,
#' and removes rows with missing values using the `clean_na_rows` function. The cleaned data for each table
#' is then saved as a separate CSV file.
#'
#' @examples
#' # Example usage:
#' \dontrun{
#' pzfx_to_csv("path/to/your/file.pzfx", "path/to/save/csvs")}
#' @importFrom utils write.csv
#' @export

pzfx_to_csv <- function(file_path, output_dir = getwd()) {

  # Check if file path is provided
  if (file_path == "") stop("Please provide a valid path to the .pzfx file")

  # List all tables in the .pzfx file
  tables <- pzfx::pzfx_tables(file_path)
  print(tables)

  # Create a list to store all extracted data
  extracted_data <- list()

  # Extract and clean data from all tables
  for (table in tables) {
    df <- pzfx::read_pzfx(file_path, table)
    df <- clean_na_rows(df)
    extracted_data[[table]] <- df
  }

  # Create output directory if it doesn't exist
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
    cat("Directory created at:", output_dir, "\n")
  } else {
    cat("Directory already exists:", output_dir, "\n")
  }

  # Save each table as CSV
  for (table in tables) {
    write.csv(
      extracted_data[[table]],
      file.path(output_dir, paste0(table, ".csv")),
      row.names = FALSE
    )
  }

  cat("CSV files saved in:", output_dir, "\n")
}
