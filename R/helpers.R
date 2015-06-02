
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

all_fields <- c("Description", "Imports", "Suggests",
                "Depends", "Enhances", "LinkingTo", "URL",
                "BugReports", "Author", "Authors@R", "Maintainer")

read_description <- function() {
  read.dcf("DESCRIPTION", keep.white = all_fields)
}

write_description <- function(desc) {
  write.dcf(desc, file = "DESCRIPTION", keep.white = all_fields)
}
