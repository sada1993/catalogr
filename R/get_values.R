#' @title Get all values in a catalog
#' @description Get all values in a catalog in either a list of a dataframe
#' @param catalog A list returned by read_catalog
#' @param return_df A boolean indicating if a dataframe should be returned
#' @return A list or a dataframe of all values in the catalog
#' @export
get_values <- function(catalog, return_df = FALSE) {
  if (length(catalog) == 0) {
    return(NULL)
  }

  catalog_values <- lapply(
    catalog,
    function(x) {
      x <- rlist::list.match(unlist(x), "value")
      names(x) <- NULL
      return(x)
    }
  )

  if (return_df) {
    catalog_values <- lapply(
      seq_along(catalog_values),
      function(i) {
        data.frame(filename = names(catalog_values)[i], value = catalog_values[[i]], stringsAsFactors = FALSE)
      }
    )
    catalog_values <- Reduce(function(left, right) rbind(left, right), catalog_values)
  }
  return(catalog_values)
}
