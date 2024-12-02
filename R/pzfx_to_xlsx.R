#' Convert .pzfx Files to XLSX
#'
#' This function reads tables from a GraphPad Prism (.pzfx) file, cleans the data by removing rows with all NA values,
#' and saves each table as a separate sheet in an Excel workbook (.xlsx format). It provides a simple way to convert the
#' data from GraphPad Prism files into a more commonly used format like Excel for further analysis.
#'
#' @param file_path A character string specifying the path to the .pzfx file to be processed.
#'   It must point to a valid file on your system.
#' @param output_dir A character string specifying the directory where the Excel file should be saved.
#'   Defaults to the current working directory (`getwd()`).
#'
#' @return None. The function saves the extracted data as an Excel file in the specified directory.
#'
#' @details
#' The function first lists all the tables in the given .pzfx file, extracts the data from each table,
#' and removes rows with missing values using the `clean_na_rows` function. Each table is then added as a separate
#' sheet in an Excel workbook. The workbook is then saved in the specified directory.
#'
#' @examples
#' # Example usage:
#' \dontrun{
#' pzfx_to_xlsx("path/to/your/file.pzfx", "path/to/save/excel")}
#'
#' @export
pzfx_to_xlsx <- function(file_path, output_dir = getwd()) {

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

  # Create a new Excel workbook
  wb <- openxlsx::createWorkbook()  # Explicit namespace for openxlsx

  # Add each table as a sheet
  for (table in names(extracted_data)) {
    openxlsx::addWorksheet(wb, sheetName = table)  # Explicit namespace
    openxlsx::writeData(wb, sheet = table, extracted_data[[table]])  # Explicit namespace
  }

  # Save the workbook
  excel_file <- file.path(output_dir, "extracted_data.xlsx")
  openxlsx::saveWorkbook(wb, excel_file, overwrite = TRUE)  # Explicit namespace

  cat("Excel file created and saved at:", excel_file, "\n")
}
