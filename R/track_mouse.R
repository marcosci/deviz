#' track_mouse
#'
#' @param time Time format, either "99h99m99s" or "inf", see details
#' @param file Path and filename, file format must currently be ".txt"
#' @param as_job Should the function be started as RStudio Job? (logical)
#'
#' @details
#' track_mouse is a function that is best run as a background job, since it blocks
#' the R shell. See our README for a walkthrough of this.
#'
#' The time format should be something of the following:
#' \itemize{
#' \item "3h23m04s"
#' \item "inf"
#' }
#'
#' If you run
#' @export
#'
#' @examples
#' \dontrun{
#' track_mouse("0h10m00s", "mouse_position.txt")
#' }
track_mouse <- function(time,
                        file,
                        as_job = FALSE) {

  #### check time format ----
  tm_units <- strsplit(time, '([0-9])')
  if(!any(c("h", "m", "s", "inf") %in% tm_units[[1]])) stop("You need to provide a correct time format.")
  if(tm_units != "inf" & !all(c("h", "m", "s") %in% tm_units[[1]])) stop("You need to provide a correct time format.")

   #### check file format ----
  file_format <- strsplit(file, "[.]")[[1]][2]
  if(file_format != "txt") stop("You need to provide a correct file format.")

  time_h <- as.numeric(strsplit(time, '([a-z])')[[1]][1])
  time_m <- as.numeric(strsplit(time, '([a-z])')[[1]][2])
  time_s <- as.numeric(strsplit(time, '([a-z])')[[1]][3])

  internal_time <- (time_h * 60 * 60) +
                   (time_m * 60) +
                    time_s

  system_info <- Sys.info()

  ## run under unix ----
  if (isFALSE(as_job)) {
    if (system_info["sysname"] != "Windows") {
      if (time != "inf") {
        .run_time(internal_time, file)
      } else {
        .run_file(file)
      }
    }
  } else {

    tmp_rscript <- tempfile(fileext = ".R")

    cat("ggmouse::track_mouse('", time,"', '", file, "')\n", file = tmp_rscript, sep = "", append = TRUE)
    cat("momove <- ggmouse::import_mouse('", file, "')", file = tmp_rscript, sep = "", append = TRUE)

    rstudioapi::jobRunScript(tmp_rscript, exportEnv = "R_GlobalEnv")

  }


}

.run_time <- function(internal_time, file){
  system(paste0(
    'secs=', internal_time,
    '; endTime=$(( $(date +%s) + secs )); while [ $(date +%s) -lt $endTime ]; do xdotool getmouselocation | sed -E "s/ screen:0 window:[^ ]*|x:|y://g"  >> ',
    file,
    '; done'
  ))
}

.run_file <- function(file){
  system(paste0(
    'while true; do xdotool getmouselocation | sed -E "s/ screen:0 window:[^ ]*|x:|y://g"  >> ',
    file,
    '; done'
  ))
}
