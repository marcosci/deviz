#' ggmouse
#'
#' @details
#'
#'
#' @import ggplot2
#' @export

ggmouse <- function(track) {

  day <- Sys.Date()

  ggplot(track, aes(x, y)) +
    geom_path(color = "#fba298", alpha = .4) +
    theme_void() +
    expand_limits(x = 0, y = 0) +
    labs(title = day, x = NULL, y = NULL) +
    theme(
      plot.title = element_text(
        size = 15,
        vjust = -2,
        hjust = -1,
        face = "bold"
      ),
      plot.background = element_rect(fill = "#e6eaeb", color = "#e6eaeb"),
    )
}
