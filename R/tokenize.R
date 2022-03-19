tokenize <- function(file_lines, token) {
  parsed_lines <- list()
  counter <- 1
  for (line in file_lines) {
    line <- remove_starting_spaces(line)
    if (does_token_exist(line, token)) {
      if (is_line_format_correct(line, token)) {
        label <- remove_ending_spaces(parse_label(line, token))
        value <- strsplit(parse_value(line, token), ",")[[1]]
        value <- sapply(value, remove_starting_spaces, USE.NAMES = FALSE, simplify = TRUE)
        value <- sapply(value, remove_ending_spaces, USE.NAMES = FALSE, simplify = TRUE)

        parsed_lines[[counter]] <- list(label = label, value = value)
        counter <- counter + 1
      } else {
        warning(glue::glue("Expression must be in the form {token} label:[value]"))
        next()
      }
    }
  }
  return(parsed_lines)
}


# Parse components of line -----
parse_label <- function(string, token) {
  label <- gsub(glue::glue("^{token}(.*): *\\[.*\\].*$"), "\\1", string)
  remove_starting_spaces(label)
}

parse_value <- function(string, token) {
  label <- gsub(glue::glue("^{token}.*: *\\[(.*)\\].*$"), "\\1", string)
  remove_starting_spaces(label)
}



# Format checks ------
does_token_exist <- function(string, token) {
  grepl(glue::glue("^{token}.*$"), string)
}

is_line_format_correct <- function(string, token) {
  one_exists <- function(char, string) {
    if (char %in% c(".", "+", "*", "?", "^", "$", "(", ")", "[", "]", "{", "}", "|", "\\")) {
      # Escame regular expression special characters
      char <- glue::glue("\\{char}")
    }
    char_idx <- gregexpr(char, string)[[1]]
    if (-1 %in% char_idx) {
      return(FALSE)
    } else if (length(char_idx) != 1) {
      return(FALSE)
    } else {
      return(TRUE)
    }
  }

  if (one_exists(":", string) &&
    one_exists("[", string) &&
    one_exists("]", string)) {
    return(grepl(glue::glue("^{token}.*: *\\[.*\\].*$"), string))
  } else {
    return(FALSE)
  }
}
# Utility Functions --------
remove_starting_spaces <- function(string) {
  gsub("^ *", "", string)
}

remove_ending_spaces <- function(string) {
  gsub(" *$", "", string)
}
