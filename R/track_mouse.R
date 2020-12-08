track_mouse <- function(time,
                        file) {

  #### needs consistency check here !!!!

  time_h <- as.numeric(strsplit(time, '([a-z])')[[1]][1])
  time_m <- as.numeric(strsplit(time, '([a-z])')[[1]][2])
  time_s <- as.numeric(strsplit(time, '([a-z])')[[1]][3])

  internal_time <- (time_h * 60 * 60) +
                   (time_m * 60) +
                   time_s

  system_info <- Sys.info()

  ## run under macos ----
  if (system_info["sysname"] == "Darwin") {
    if (time == "inf") {
      system(paste0(
        'secs=', internal_time,
        'endTime=$(( $(date +%s) + secs ))

        while [ $(date +%s) -lt $endTime ]; do
        xdotool getmouselocation | sed -E "s/ screen:0 window:[^ ]*|x:|y://g"  >>', file,
        'done'
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


strsplit(time, '([a-z])')

