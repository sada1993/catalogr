#' @title Search a label in a catalog
#' @description Get a catalog for a given label
#' @param catalog A list returned by read_catalog
#' @param label_str A label to search
#' @return A catalog with only the label in label_str
#' @export
search_label <- function(catalog, label_str) {
  matching_label_lst <- lapply(catalog, function(x) rlist::list.filter(x, label == label_str))
  non_empty_elements <- lapply(matching_label_lst, length) > 0
  return(matching_label_lst[non_empty_elements])
}
