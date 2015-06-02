
copy_template <- function(generator) {
  name <- pkg_name(generator)
  srcdir <- system.file("template", package = name)
  srcfiles <- dir(srcdir, all.files = TRUE, no.. = TRUE, full.names = TRUE)
  res <- file.copy(srcfiles, ".", recursive = TRUE, overwrite = FALSE)
}

#' @importFrom whisker whisker.render

moustache_template <- function(answers) {

  files <- dir(all.files = TRUE, no.. = TRUE, recursive = TRUE,
               full.names = TRUE)

  for (f in files) {
    input <- readBin(f, raw(), n = file.info(f)$size)

    ## Binary file? Skip.
    if (any(input == 0)) next

    input <- rawToChar(input)
    output <- whisker.render(input, data = answers)
    writeChar(output, f, eos = NULL)
  }

  invisible()
}
