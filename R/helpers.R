
#' @importFrom description description
#' @export

add_dependency <- function(deptype, packages) {
  desc <- description$new()
  desc$set_dep(packages, deptype)
  desc$write()
}
