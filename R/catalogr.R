#> author: [akash]
#' @title Catalog a directory
#' @description
#' Catalog a directory of files
#'
#' @param dir current working directory
#' @param fileformat list with the keys as file type and a value with the comment token.
#' These are the only files read by the package. By default R and SQL files are supported.
#' @param write_yaml boolen value, if FALSE then the function returns a list object
#' @param yaml_filepath if `write_yaml` is TRUE, this specifies the filepath and filename to store the file in.
#' @param recursive recursively follow all directories starting from the current directory
#' @examples
#' # Catalog all .R files in the current working directory
#' catalogr()
#' # Catalog R and SQL files.
#' # Catalogs the metadata available
#' catalogr(fileformat = list(".R" = "#>", ".sql" = "-->"))
#' @export
catalogr <- function(dir = getwd(), fileformat = list(`.R` = "#>", `.sql` = "-->"), write_yaml = TRUE, yaml_filepath = file.path(getwd(), "catalogr.yaml"), recursive = TRUE) {
  files <- list.files(path = dir, recursive = recursive, full.names = TRUE)
  accepted_fileformats <- names(fileformat)
  parsed_values <- list()
  for (file in files) {
    file_extension <- gsub("^.*(\\..*$)", "\\1", file)
    if (tolower(file_extension) %in% tolower(accepted_fileformats)) {
      token_for_file_type <- fileformat[[which(tolower(accepted_fileformats) %in% tolower(file_extension))]]
      lines <- readLines(file)
      tokens <- tokenize(lines, token_for_file_type)
      if (length(tokens) != 0) {
        parsed_values[[file]] <- tokens
      }
    }
  }

  if (write_yaml) {
    yaml::write_yaml(parsed_values, file = yaml_filepath) # nocov
  } else {
    return(parsed_values)
  }
}
