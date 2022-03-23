#' @title Read a Catalog
#' @description A convenient yaml wrapper to read a catalog yaml file that is saved through `caralogr()`
#' @param yaml_filepath the filepath of the saved catalog file
#' @export
read_catalog <- function(yaml_filepath = getwd()){
  yaml::read_yaml(yaml_filepath)
}
