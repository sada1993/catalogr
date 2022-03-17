tokenize <- function(file_lines, token){
  parsed_lines <- list()
  for(i in seq_along(file_lines)){
    line <- remove_starting_spaces(file_lines[i])
    if(is_line_format_correct(string, token)){

    }else{
      warning(glue::glue("Expression must be in the form {token} label:[value]"))
      next()
    }
  }
}


# Parse components of line -----
parse_label <- function(string, token){
  label <- gsub(glue::glue("^{token}(.*): *\\[.+\\]$"),"\\1", string)
  remove_starting_spaces(label)
}

parse_value <- function(string, token){
  label <- gsub(glue::glue("^{token}(.*): *\\[.+\\]$"),"\\1", string)
  remove_starting_spaces(label)
}



# Format checks ------
is_line_format_correct <- function(string, token){

  one_exists <- function(char, string){
    if(char %in% c(".", "+", "*", "?", "^", "$", "(", ")", "[", "]", "{", "}", "|", "\\")){
      # Escame regular expression special characters
      char <- glue::glue("\\{char}")
    }
    char_idx <- gregexpr(char, string)[[1]]
    if(-1 %in% char_idx){
      return(FALSE)
    }else if(length(char_idx) != 1){
      return(FALSE)
    }else{
      return(TRUE)
    }
  }

  if(one_exists(":", string) &&
     one_exists("[", string) &&
     one_exists("]", string)){
    return(grepl(glue::glue("^{token}.*: *\\[.+\\]$"), string))
  }else{
    return(FALSE)
  }
}
# Utility Functions --------
remove_starting_spaces <- function(string){
  gsub("^ *","", string)
}
