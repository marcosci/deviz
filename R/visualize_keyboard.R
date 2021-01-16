#' Visualize key tracking data
#'
#' Adds a heatmap about how often a key was pressed on keyboard from \code{\link{ggkeyboard}}
#'
#' @param keys A data.frame with data tracked by \code{\link{track_keyboard}}
#' @param ggkeyboard An input keyboard from \code{\link{ggkeyboard}}.
#' @param palette Colour palette. Defaults to \code{keyboard_palette("pastel")}. To use a custom palette, create a vector with the names described in \code{\link{keyboard_palette}}.
#' @param layout Keyboard layout - one of "ansi" or "iso". Defaults to "ansi".
#' @param font_family Font used. Defaults to "Palatino". See the \code{extrafont} package for using fonts in ggplot2.
#' @param font_size Base font size. Defaults to 3.
#' @param adjust_text_colour Whether to lighten the text colour on dark keys. Defaults to TRUE.
#' @param measurements Measurements of various aspects of the keyboard key height and width, gaps between keys and rows, etc. See \code{\link{keyboard_measurements}}.
#' @param colour Highlight outline colour.
#' @param size Highlight outline signs.
#' @param ... Additional options, passed to \code{geom_rect}.
#'
#' @export
#'
#' @examples
#' visualize_keyboard(key_df, ggkeyboard = ggkeyboard::mac)
#'
visualize_keyboard <- function(keys,
                               ggkeyboard = ggkeyboard::tkl,
                               palette = ggkeyboard::keyboard_palette("magic"),
                               layout = c("ansi", "iso"),
                               font_family = "mono",
                               font_size = 3,
                               adjust_text_colour = TRUE,
                               measurements = ggkeyboard::keyboard_measurements("default"),
                               colour = "#e5e1e1",
                               size = 1,
                               ...) {

  layout <- match.arg(layout)



  keys <- keys %>%
    dplyr::group_by(key) %>%
    dplyr::summarise(n = dplyr::n())

  keyboard <- ggkeyboard::ggkeyboard(ggkeyboard,
                                     palette = palette,
                                     layout = layout,
                                     font_family = font_family,
                                     font_size = font_size,
                                     adjust_text_colour = adjust_text_colour,
                                     measurements = measurements)

  keyboard <- ggplot2::ggplot_build(keyboard)
  keyboard <- purrr::map_dfr(keyboard$plot$layers[2:16], function(keyboard_data){
    keyboard_data$data
  }) %>% dplyr::distinct()

  keys <- clean_keyboard(keys, ggkeyboard)

  key_data <- keyboard %>%
    dplyr::filter(key %in% !!keys$key) %>%
    dplyr::distinct(key, x_start, x_end, y_start, y_end) %>%
    dplyr::left_join(keys, by = "key")

  colors <- c("#F8F4D7", "#F4DEC2", "#F2B4A8", "#F4B36C", "#E98977")

  ggkeyboard::ggkeyboard(ggkeyboard,
                         palette = palette,
                         layout = layout,
                         font_family = font_family,
                         font_size = font_size,
                         adjust_text_colour = adjust_text_colour,
                         measurements = measurements) +
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
    scale_fill_gradientn("Number of key strokes", colours = colors) +
    ggplot2::theme(legend.position = "bottom")  +
    ggplot2::guides(fill = ggplot2::guide_colorbar(title.position = "bottom",
                                                   title.hjust = 0.5,
                                                   barheight = 0.4,
                                                   barwidth = 10.4),
           override.aes = list(alpha = 1))


}
