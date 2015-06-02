
str_trim <- function(text) {
  gsub("\\s$", "", gsub("^\\s+", "", text))
}
