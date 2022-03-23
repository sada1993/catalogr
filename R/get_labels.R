#' @title Get all Labels
#' @description Get all labels from a given catalog
#' @param catalog A list retured by read_catalog()
#' @return A vector of unique labels in a catalog
#' @export
get_labels <- function(catalog) {
  if (length(catalog) == 0) {
    return(NULL)
  }
  flat_catalog <- unlist(rlist::list.flatten(catalog))
  flat_catalog_values <- rlist::list.match(flat_catalog, "label")
  return(unique(flat_catalog_values[order(flat_catalog_values)]))
}
