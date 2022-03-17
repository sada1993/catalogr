#' @title Catalog a directory
#' @description
#' Catalog a directory of files
#'
#' @param dir current working directory
#' @param fileformat list with the keys as file type and value with the token
#' @param recursive recursively follow all directories starting from the current directory
#'
#' @examples
#' # Catalog all .R files in the current working directory
#' catalogr()
#' # Catalog R and SQL files.
#' # Catalogs the metadata available
#' catalogr(fileformat = list(".R" = "#>", ".sql" = "-->"))
#' @export
catalogr <- function(dir = getwd(), fileformat = list(`.R` = "#>"), recursive = TRUE){
  lines <- read_files("R/example.R")
  tokenize(lines)
}
