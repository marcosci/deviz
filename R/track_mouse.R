#' track_mouse
#'
#' @param time Time format, either "99h99m99s" or "inf", see details
#' @param file Path and filename, file format must currently be ".txt"
#'
#' @details
#' track_mouse is a function that is best run as a background job, since it blocks
#' the R shell. See our README for a walkthrough of this.
#'
#' The time format should be something of the following:
#' \itemize{
#' \item "3h23m04s"
#' \item "3h23m"
#' \item "23m04s"
#' \item "23m"
#' \item "inf"
#' }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' track_mouse("0h10m00s", "mouse_position.txt")
#' }
track_mouse <- function(time,
                        file) {

  #### check time format ----
  tm_units <- strsplit(time, '([1-9])')
  if(!any(c("h", "m", "s", "inf") %in% tm_units[[1]])) stop("You need to provide a correct time format.")

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
  if (system_info["sysname"] != "Windows") {
    if (time == "inf") {
      system(paste0(
        'secs=', internal_time,
        '; endTime=$(( $(date +%s) + secs )); while [ $(date +%s) -lt $endTime ]; do xdotool getmouselocation | sed -E "s/ screen:0 window:[^ ]*|x:|y://g"  >> ',
        file,
        '; done'
      ))
    } else {
      system(paste0(
        'while true; do xdotool getmouselocation | sed -E "s/ screen:0 window:[^ ]*|x:|y://g"  >> ',
        file,
        '; done'
      ))

    }
  }

}



