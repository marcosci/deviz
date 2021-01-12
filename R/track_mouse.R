#' track_mouse
#'
#' @param time Time format, "99h99m99s"
#' @param as_job Should the function be started as RStudio Job? (logical)
#'
#' @details
#' track_mouse is a function that is best run as a background job, since it blocks
#' the R shell. See our README for a walkthrough of this.
#'
#' If you run
#' @export
#'
#' @import reticulate
#'
#' @examples
#' \dontrun{
#' track_mouse("0h10m00s", "mouse_position.txt")
#' }
track_mouse <- function(time,
                        as_job = FALSE) {

  #### check time format ----
  tm_units <- strsplit(time, '([0-9])')
  if(!any(c("h", "m", "s", "inf") %in% tm_units[[1]])) stop("You need to provide a correct time format.")
  if(tm_units != "inf" & !all(c("h", "m", "s") %in% tm_units[[1]])) stop("You need to provide a correct time format.")

  time_h <- as.numeric(strsplit(time, '([a-z])')[[1]][1])
  time_m <- as.numeric(strsplit(time, '([a-z])')[[1]][2])
  time_s <- as.numeric(strsplit(time, '([a-z])')[[1]][3])

  internal_time <- (time_h * 60 * 60) +
                   (time_m * 60) +
                    time_s

  py_run_string(paste0("
from pynput import mouse
import time

event_list = []
t_end = time.time() +", internal_time ,"

with mouse.Events() as events:
    for event in events:
        if time.time() > t_end:
            break
        else:
            event_list.append([event, time.strftime('%Y-%m-%d', time.localtime()), time.strftime('%H:%M:%S', time.localtime())])
"))

  event_list <- py$event_list

  mouse_events <- purrr::map_dfr(event_list, function(events){

    event <- paste(events[[1]])

    x_coord <- as.numeric(regmatches(event, regexec("x=\\s*(.*?)\\s*,", event))[[1]][2])
    y_coord <- if(is.na(as.numeric(regmatches(event, regexec("y=\\s*(.*?)\\s*)", event))[[1]][2]))){
      as.numeric(regmatches(event, regexec("y=\\s*(.*?)\\s*,", event))[[1]][2])
    } else {
      as.numeric(regmatches(event, regexec("y=\\s*(.*?)\\s*)", event))[[1]][2])
    }

    tibble::tibble(type    = regmatches(event, regexec("\\s*(.*?)\\s*\\(", event))[[1]][2],
                   x       = x_coord,
                   y       = y_coord,
                   button  = regmatches(event, regexec("Button.\\s*(.*?)\\s*,", event))[[1]][2],
                   pressed = regmatches(event, regexec("pressed=\\s*(.*?)\\s*)", event))[[1]][2],
                   dx      = regmatches(event, regexec("dx=\\s*(.*?)\\s*,", event))[[1]][2],
                   dy      = regmatches(event, regexec("dy?\\s*(.*?)\\s*,", event))[[1]][2],
                   date    = lubridate::ymd(events[[2]]) + lubridate::hms(events[[3]]))
  })

  ## run as job ----
  if (as_job) {

    tmp_rscript <- tempfile(fileext = ".R")
    cat(paste0("mouse_df <- deviz::track_mouse('", time, "')"), file = tmp_rscript)
    rstudioapi::jobRunScript(tmp_rscript, exportEnv = "R_GlobalEnv")

  }

  return(mouse_events)

}
