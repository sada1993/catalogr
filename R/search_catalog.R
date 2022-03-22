#' @title Search Catalog
#' @description Search the catalog and return a filename.
#' @param catalog A list retured by read_catalog
#' @param label A string indicating the label we wish to search
#' @param  search_valye a search string
#' @return a list of matched filenames
#' @export
search_catalog <- function(catalog, search_value, label = NULL){

  if(!is.null(label)){
    catalog <- find_label(catalog, label)
  }

  return(find_value(catalog, search_value))
}


find_label <- function(catalog, label_str){
  matching_label_lst <- lapply(catalog, function(x) rlist::list.filter(x, label == label_str))
  non_empty_elements <- lapply(matching_label_lst, length) > 0
  return(matching_label_lst[non_empty_elements])
}

find_value <- function(catalog, value){

  flat_catalog <- rlist::list.flatten(catalog)
  flat_catalog_values <- rlist::list.match(flat_catalog, "value")
  value_filenames <- gsub("\\.value$", "", names(flat_catalog_values))
  names(flat_catalog_values) <- value_filenames
  similarity <- stringdist::stringsim(tolower(flat_catalog_values),tolower(value))

  similarity_df <- aggregate(similarity, by = list(filenames = value_filenames), FUN = sum)

  top_filenames <- similarity_df[order(similarity_df$x, decreasing = TRUE),]$filenames

  return(top_filenames)
}
