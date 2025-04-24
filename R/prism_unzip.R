#' Unzips a .prism file
#'
#' Given a path to a “.prism” file, this function will create a sibling “_unzipped” folder (named after the file) and unzip everything into it.
#'
#' @param prism_path Path to the `.prism` file to extract.
#' @param output_dir Optional parent directory in which to create the `_unzipped`
#'   folder. Defaults to the directory containing `prism_path`.
#' @return Invisibly returns the full path to the folder where the files were unzipped.
#' @export


prism_unzip <- function(prism_path,
                        output_dir = dirname(prism_path)) {

  if (!nzchar(prism_path) || !file.exists(prism_path)) {
    stop("`prism_path` must point to an existing .prism file.")}


  base <- tools::file_path_sans_ext(basename(prism_path))
  unzip_dir <- file.path(output_dir, paste0(base, "_unzipped"))


  if (!dir.exists(unzip_dir)) {
    dir.create(unzip_dir, recursive = TRUE)
    message("Created folder: ", normalizePath(unzip_dir))
     }else {
    message("Using existing folder: ", normalizePath(unzip_dir))}

  utils::unzip(prism_path, exdir = unzip_dir)
  message("Unzipped `",
          basename(prism_path),
          "` into:\n  ",
          normalizePath(unzip_dir))

  invisible(normalizePath(unzip_dir))


  }
