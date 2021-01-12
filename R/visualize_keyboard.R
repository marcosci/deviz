#' Visualize key tracking data
#'
#' Adds a heatmap about how often a key was pressed on keyboard from \code{\link{ggkeyboard}}
#'
#' @param keys A data.frame with data tracked by \code{\link{track_keyboard}}
#' @param ggkeyboard An input keyboard from \code{\link{ggkeyboard}}.
#' @param keys Keys to highlight. Key names are available from the \code{key} column of the data passed to \code{ggkeyboard}.
#' @param colour Highlight outline colour.
#' @param fill Highlight fill colour.
#' @param size Highlight outline signs.
#' @param ... Additional options, passed to \code{geom_rect}.
#'
#' @export
#'
#' @examples
#' visualize_keyboard(key_df)
#'
visualize_keyboard <- function(keys,
                               ggkeyboard = ggkeyboard::tkl,
                               palette = ggkeyboard::keyboard_palette("magic"),
                               colour = "#cd5c5c",
                               size = 1,
                               ...) {

  keys <- keys %>%
    dplyr::group_by(key) %>%
    dplyr::summarise(n = dplyr::n())

  keyboard <- ggkeyboard:::construct_keyboard(ggkeyboard)

  key_data <- keyboard %>%
    dplyr::filter(key %in% !!keys$key) %>%
    dplyr::distinct(key, x_start, x_end, y_start, y_end) %>%
    dplyr::left_join(keys, by = "key")

  ggkeyboard::ggkeyboard(ggkeyboard, palette = palette) +
    ggnewscale::new_scale_fill() +
    ggplot2::geom_rect(
      data = key_data,
      ggplot2::aes(
        xmin = x_start, xmax = x_end,
        ymin = y_start, ymax = y_end,
        fill = n
      ),
      colour = colour,
      size = size,
      alpha = 0.5
    ) +
    ggplot2::scale_fill_viridis_c() +
    ggplot2::theme(legend.position="bottom",
          legend.direction='horizontal')  +
    ggplot2::guides(fill = ggplot2::guide_legend(title.position = "bottom",
                               title.hjust = 0.5),
           override.aes = list(alpha = 1))


}
