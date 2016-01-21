
#' Run a generator
#'
#' If no generator is given, then you can choose one interactively.
#' It will generate the application in the current working directory,
#' and it expects it to be empty.
#'
#' @param generator The name of the generator to run. This is the initial
#'   part of the package name that defines the generator.
#'
#' @export
#' @importFrom ask ask_
#' @importFrom crayon yellow red bold
#' @importFrom praise praise
#' @importFrom clisymbols symbol

mason <- function(generator = NULL) {

  if (is.null(generator)) {
    return(mason_default())
  }

  check_dir_empty()

  ## Get the survey and run it
  survey <- get_survey(generator)

  say("\nHello ", yellow(username()), "!\n\n",
      "Mason here. I see we are\n",
      "building an R package.\n",
      "Please answer these questions.\n")

  cat("\n")

  answers <- ask_(survey, .prompt = yellow("? "))

  ## Copy over the template and fill in the blanks
  copy_template(generator)
  moustache_template(answers)

  ## Post-processing
  run_generator_build(generator, answers)

  cat(
    sep = "",
    "\n",
    bold(red(symbol$heart)),
    praise(" ${Exclamation}! What a ${adjective} package this will be!\n\n")
  )
}

#' @importFrom whoami username

mason_default <- function() {
  say("Hello ", username(), "!\n",
      "I am Mason, a friendly builder. I can help you ",
      "to create slick R packages.\n",
      "Please see more at ",
      red("https://github.com/metacran/mason"))
}

#' @importFrom utils globalVariables
NULL

if(getRversion() >= "2.15.1") globalVariables("confirm")

#' @importFrom ask ask

check_dir_empty <- function() {
  files <- dir(all.files=TRUE, no.. = TRUE)
  if (length(files)) {
    ans <- ask(proceed = confirm("Directory not empty. Proceed?",
                 default = FALSE))
    if (! ans$proceed) stop("Directory not empty, quitting")
  }
}

pkg_name <- function(generator) {
  paste0("mason.", generator)
}

#' @importFrom falsy %||% try_quietly
#' @importFrom utils packageDescription

get_survey <- function(generator) {
  name <- pkg_name(generator)
  try_quietly(ns <- asNamespace(name)) %||%
    stop("Package not installed: ", name)

  title <- packageDescription(name)$Title
  title <- sub(" (Generator)? for Mason$", "", title)

  survey <- try_quietly(getFromNamespace("survey", asNamespace(name))) %||%
    stop("Package has no `survey` object: ", name)

  attr(survey, "title") <- title
  survey
}

#' @importFrom falsy %||% try_quietly

run_generator_build <- function(generator, answers) {
  name <- pkg_name(generator)
  try_quietly(builder <- getFromNamespace("build", asNamespace(name))) %||%
    stop("Package has no `build` function: ", name)
  builder(answers)
}
