#' @title Search Catalog
#' @description Search the catalog and return a filename.
#' @param catalog A list retured by read_catalog
#' @param  search_value a search string
#' @param label A string indicating the label we wish to search. If NULL it matches all labels.
#' @return a list of matched filenames
#' @export
search_catalog <- function(catalog, search_value, label = NULL) {
  if (!is.null(label)) {
    catalog <- find_label(catalog, label)
  }

  return(find_value(catalog, search_value))
}


find_label <- function(catalog, label_str) {
  matching_label_lst <- lapply(catalog, function(x) rlist::list.filter(x, label == label_str))
  non_empty_elements <- lapply(matching_label_lst, length) > 0
  return(matching_label_lst[non_empty_elements])
}

find_value <- function(catalog, value) {
  # Further unlist it to remove nested vectors
  # We need a list with only values, no other data structures nested.
  # This is required for the similarity calculation
  if (length(catalog) == 0) {
    return(NULL)
  }
  flat_catalog <- unlist(rlist::list.flatten(catalog))
  flat_catalog_values <- rlist::list.match(flat_catalog, "value")

  value_filenames <- gsub("\\.value\\d*$", "", names(flat_catalog_values))

  similarity <- stringdist::stringsim(tolower(flat_catalog_values), tolower(value))

  similarity_df <- aggregate(similarity, by = list(filenames = value_filenames), FUN = sum)
  top_filenames <- similarity_df[order(similarity_df$x, decreasing = TRUE), ]$filenames
  return(top_filenames)
}
