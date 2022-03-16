#' @title CatalogR
#' @description
#' Catalog a directory of files
#'
#' @param dir current working directory
#' @param fileformat list with the keys as file type and value with the token
#'
#' @examples
#' # Catalog all .R files in the current working directory
#' catalogr()
#' # Catalog R and SQL files.
#' # Catalogs the metadata available
#' catalogr(fileformat = list(".R" = "#>", ".sql" = "-->"))
#' @export
catalogr <- function(dir = getwd(), fileformat = list(`.R` = "#>"), recursive = TRUE){

}
