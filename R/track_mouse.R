track_mouse <- function(time,
                        file){



  if (time = "inf") {
    system(paste0('while true; do xdotool getmouselocation | sed -E "s/ screen:0 window:[^ ]*|x:|y://g"  >> ',
                  file,
                  '; done'))
  }

}

