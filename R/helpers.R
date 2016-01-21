
#' @export

add_dependency <- function(deptype, packages) {
  desc <- read_description()

  if (deptype %in% colnames(desc)) {
    current <- str_trim(strsplit(desc[, deptype], ",")[[1]])
    packages <- setdiff(packages, current)
    if (length(packages)) {
      packages <- paste0(packages, collapse = ",\n    ")
      desc[, deptype] <- paste0(desc[, deptype], ",\n    ", packages)
    }

  } else {
    packages <- paste0("\n    ", paste0(packages, collapse = ",\n    "))
    dep <- matrix(packages, dimnames = list(rownames(desc), deptype))
    desc <- cbind(desc, dep)
  }

  write_description(desc)
}

read_description <- function(file = "DESCRIPTION") {
  lines <- readLines(file)

  con <- textConnection(lines, local = TRUE)
  fields <- colnames(read.dcf(con))
  close(con)

  con <- textConnection(lines, local = TRUE)
  res <- read.dcf(con, keep.white = fields)
  close(con)

  res
}

write_description <- function(desc, file = "DESCRIPTION") {
  write.dcf(desc, file = file, keep.white = colnames(desc))
}
