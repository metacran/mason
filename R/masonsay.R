
#' @importFrom crayon red

ascii_mason <- c(
     ("       _____      "),
     ("     .'     '.    "),
     ("    |  .__._  |   "),
     ("    \\ ;_____\\ /   "),
     ("    (|| 0|0 ||)   "),
     ("     |'-(_)-'|    "),
     ("     \\ .___. /    "),
     ("jgs   '.-  .'     "),
     ("  .-'|  '-'  |`--."),
  red("_|___|_______|___|"),
  red("___|___|___|___|__"),
  red("_|___|___|___|___|")
)

say <- function(...) {
  text <- paste0(..., collapse = "")
  width <- min(70, getOption("width"))
  ttext <- strsplit(text, "\n")[[1]]
  ttext <- strwrap(ttext, width = width - max(col_nchar(ascii_mason)) - 10)
  ttext <- center_text(ttext)
  cat(add_bubble(ascii_mason, ttext), sep = "\n")
}

#' @importFrom crayon col_nchar

center_text <- function(text) {
  nc <- col_nchar(text)
  width <- max(nc)
  sp_pre <- floor((width - nc) / 2)
  sp_pos <- ceiling((width - nc) / 2)
  paste0(space(sp_pre), text, space(sp_pos))
}

space <- function(len, chr = " ") {
  vapply(len, function(x) paste(rep(chr, x), collapse = ""), "")
}

#' @importFrom crayon col_nchar

add_bubble <- function(cat, text, gap = 5) {

  ## Cut the text if it is too long
  if (length(text) + 2 > length(cat)) {
    text <- text[1:(length(cat)-3)]
  }

  ## Bubble
  gap <- space(gap)
  line <- space(max(col_nchar(text)) + 2, '-')
  line_top <- paste0(gap, '.', line, '.')
  line_bot <- paste0(gap, "'", line, "'")
  text <- c(line_top, paste0(gap, '| ', text, ' |'), line_bot)

  lines_pre <- floor((length(cat) - length(text)) / 2)
  lines_post <-ceiling((length(cat) - length(text)) / 2)

  ## Shift it up, it there is space
  if (lines_pre > 0) {
    lines_pre <- lines_pre - 1
    lines_post <- lines_post + 1
  }

  paste0(cat, c(rep("", lines_pre), text, rep("", lines_post)))
}
