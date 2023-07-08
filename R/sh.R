#' Launch a linux bash shell
#'
#' @param command
#' @param current_dir
#' @param complete_path
#' @param intern
#'
#' @return
#' @export
#'
#' @examples
sh <- function(command = NULL,
               current_dir = getwd(),
               complete_path = FALSE,
               intern = FALSE) {
  if (!is.null(command)) {
    system(command, intern = intern)
  } else {
    while (TRUE) {
      r <- readline(format_prompt(complete_path, current_dir))
      if (r == "exit")
        return(invisible())
      if (stringr::str_starts(r, "cd "))
        current_dir <- treat_cd_case(r, current_dir)
      else
        system(stringr::str_c("cd ", current_dir, " && ", r))
    }
  }
}

parent_dir <- function(dir) {
  if (dir == "/")
    return("/")
  else
    stringr::str_replace(dir, "/[^/]*$", "")
}


treat_cd_case <- function(r, current_dir) {
  new_directory_name <-
    stringr::str_trim(stringr::str_remove(r, "cd "))
  new_directory <- paste0(current_dir, "/", new_directory_name)

  if (!fs::dir_exists(new_directory)) {
    cat(new_directory, "is not an existing directory...")
    return(current_dir)
  }
  current_dir <-
    system(stringr::str_c("cd ", current_dir, " && ",
                          r , " && pwd"),
           intern = T)
  system(stringr::str_c("cd ", current_dir, " && ls"))
  return(current_dir)
}


format_prompt <- function(complete_path, current_dir) {
  short_name <- function(dir)
    stringr::str_extract(dir, "[^/]*$")

  if (complete_path)
    path <- current_dir
  else
    path <- short_name(current_dir)
  stringr::str_c(path, " $ ")
}
