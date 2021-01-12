#' calc_dist
#'
#' @param file Mouse track containing x any y coordinates#'
#'
#' @details
#' Calculate distance in pixels between track points
#'
#' @return mouse track including distance#'
#' @export
#'
#' @examples
#' calc_dist(mouse_track)
#'

calc_dist <- function(file) {

  #### initialize distance column ----

  file["dist"] <- as.numeric(NA)

  #### get number of rows ----

  n <- nrow(file)

  #### calculate euclidean distance between points ----

  file$dist[2:n] <- sqrt((file$x[2:n] - file$x[1:n-1]) ^ 2 + (file$y[2:n] - file$y[1:n-1]) ^ 2)

  #### get rid of NAs ----

  file$dist[is.na(file$dist)] <- 0

  return(file)

}
