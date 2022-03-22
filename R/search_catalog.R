#' @title Search Catalog
#' @description Search the catalog and return a filename.
#' @param catalog A list retured by read_catalog
#' @param label A string indicating the label we wish to search
#' @param  search_valye a search string
#' @return a list of matched filenames
#' @export
search_catalog <- function(catalog, label, search_value){

}


find_label <- function(catalog, label_value){
  matching_label_lst <- lapply(catalog, function(x) rlist::list.find(x, label == label_value))
  non_empty_elements <- lapply(matching_label_lst, length) > 0
  return(matching_label_lst[non_empty_elements])
}
