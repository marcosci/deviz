#' calc_dist
#'
#' @param track Mouse track containing x any y coordinates
#' @param cumulative Return distance as cumulative sum or not, logical, default is true
#'
#' @details
#' Calculate distance in pixels between track points that are of type 'Move'.
#'
#' @return mouse track including distance
#' @export
#'
#' @examples
#' calc_dist(mouse_df)
#'
calc_dist <- function(track, cumulative = TRUE) {

  #### filter for mouse movement ----
  track <- track %>%
    dplyr::filter(type == "Move")

  #### initialize distance column ----
  track["dist"] <- as.numeric(NA)

  #### get number of rows ----
  n <- nrow(track)

  #### calculate euclidean distance between points ----
  track$dist[2:n] <- sqrt((track$x[2:n] - track$x[1:n-1]) ^ 2 + (track$y[2:n] - track$y[1:n-1]) ^ 2)

  #### get rid of NAs ----
  track$dist[is.na(track$dist)] <- 0

  #### to be cumulative or not, that is the question ----
  if(cumulative) track$dist <- cumsum(track$dist)

  return(track)

}
