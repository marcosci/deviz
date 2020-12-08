#' ggmouse
#'
#' @details
#'
#'
#' @import ggplot2
#' @export

ggmouse_raw <- function(track) {

  day <- Sys.Date()

  ggplot(track, aes(x, y)) +
    geom_path(color = "#fba29866") +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0)) +
    labs(title = day) +
    theme_void() +
    theme(
      plot.title = element_text(
        size = 15,
        #vjust = 2,
        hjust = 0,
        face = "bold",
        margin = margin(0, 0, 5, 0),
        color = "#768a90"
      ),
      plot.margin = margin(30, 45, 45, 45),
      plot.background = element_rect(fill = "#e6eaeb", color = "#e6eaeb"),
      panel.background = element_rect(fill = "#e6eaeb", color = "#cad2d4", size = 1)
    ) #+
    #ggsave(here::here("plots", "test_raw.pdf"), width = 16, height = 9, device = cairo_pdf)
}

ggmouse_dot <- function(track) {

  day <- Sys.Date()

  track$id <- 1:nrow(track)

  ggplot(track, aes(x, y)) +
    geom_point(
      data = track[1,],
      shape = 24,
      size = 4,
      fill = "white",
      color = "black",
      stroke = 2
    ) +
    geom_point(
      data = track[nrow(track),],
      shape = 23,
      size = 4,
      fill = "white",
      color = "black",
      stroke = 2
    ) +
    geom_point(
      aes(color = id),
      alpha = .6,
      shape = 16,
      size = .6
    ) +
    geom_point(
      data = track[1,],
      shape = 24,
      size = 4.5,
      fill = "transparent",
      color = "white",
      stroke = .7
    ) +
    geom_point(
      data = track[nrow(track),],
      shape = 23,
      size = 4.5,
      fill = "transparent",
      color = "white",
      stroke = .7
    ) +
    scale_x_continuous(expand = c(.01, .01)) +
    scale_y_continuous(expand = c(.01, .01)) +
    rcartocolor::scale_color_carto_c(
      palette = "SunsetDark",
      guide = "none"
    ) +
    coord_fixed() +
    labs(title = day) +
    theme_void() +
    theme(
      plot.title = element_text(
        size = 15,
        #vjust = 2,
        hjust = 0,
        face = "bold",
        margin = margin(0, 0, 5, 0),
        color = "#768a90"
      ),
      plot.margin = margin(30, 45, 45, 45),
      plot.background = element_rect(fill = "#e6eaeb", color = "#e6eaeb"),
      panel.background = element_rect(fill = "#e6eaeb", color = "#cad2d4", size = 1)
    ) +
    ggsave(here::here("plots", "test_dots.pdf"), width = 16, height = 9, device = cairo_pdf)
}

ggmouse_heat <- function(track) {

  day <- Sys.Date()

  ggplot(track, aes(x, y)) +
    geom_density_2d_filled() +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0)) +
    scico::scale_fill_scico_d(
      palette = "buda",
      guide = "none"
    ) +
    labs(title = day) +
    theme_void() +
    theme(
      plot.title = element_text(
        size = 15,
        #vjust = 2,
        hjust = 0,
        face = "bold",
        margin = margin(0, 0, 5, 0),
        color = "#768a90"
      ),
      plot.margin = margin(30, 45, 45, 45),
      plot.background = element_rect(fill = "#e6eaeb", color = "#e6eaeb")
    ) #+
    #ggsave(here::here("plots", "test_heatmap_buda.pdf"), width = 16, height = 9, device = cairo_pdf)
}

ggmouse_hex <- function(track) {

  day <- Sys.Date()

  ggplot(track, aes(x, y)) +
    geom_hex(aes(color = ..count..)) +
    scale_x_continuous(expand = c(.025, .025)) +
    scale_y_continuous(expand = c(.025, .025)) +
    scico::scale_color_scico(
      palette = "batlow",
      guide = "none"
    ) +
    scico::scale_fill_scico(
      palette = "batlow",
      guide = "none"
    ) +
    coord_fixed() +
    labs(title = day) +
    theme_void() +
    theme(
      plot.title = element_text(
        size = 15,
        #vjust = 2,
        hjust = 0,
        face = "bold",
        margin = margin(0, 0, 5, 0),
        color = "#768a90"
      ),
      plot.margin = margin(30, 45, 45, 45),
      plot.background = element_rect(fill = "#e6eaeb", color = "#e6eaeb")
    ) #+
    #ggsave(here::here("plots", "test_hex.pdf"), width = 16, height = 9, device = cairo_pdf)
}

ggmouse_grid <- function(track) {

  day <- Sys.Date()

  ggplot(track, aes(x, y)) +
    geom_bin2d(
      aes(color = ..count..),
      bins = 50
    ) +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0)) +
    scico::scale_color_scico(
      palette = "batlow",
      guide = "none"
    ) +
    scico::scale_fill_scico(
      palette = "batlow",
      guide = "none"
    ) +
    coord_fixed() +
    labs(title = day) +
    theme_void() +
    theme(
      plot.title = element_text(
        size = 15,
        #vjust = 2,
        hjust = 0,
        face = "bold",
        margin = margin(0, 0, 5, 0),
        color = "#768a90"
      ),
      plot.margin = margin(30, 45, 45, 45),
      plot.background = element_rect(fill = "#e6eaeb", color = "#e6eaeb")
    ) #+
    #ggsave(here::here("plots", "test_grid.pdf"), width = 16, height = 9, device = cairo_pdf)
}

ggmouse_tinygrid <- function(track) {

  day <- Sys.Date()

  m <- max(track$y, na.rm = TRUE)

  ggplot(track, aes(x, y)) +
    geom_bin2d(
      aes(color = ..count..),
      bins = m
    ) +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0)) +
    scico::scale_color_scico(
      palette = "bamako",
      guide = "none"
    ) +
    scico::scale_fill_scico(
      palette = "bamako",
      guide = "none"
    ) +
    coord_fixed() +
    labs(title = day) +
    theme_void() +
    theme(
      plot.title = element_text(
        size = 15,
        #vjust = 2,
        hjust = 0,
        face = "bold",
        margin = margin(0, 0, 5, 0),
        color = "#768a90"
      ),
      plot.margin = margin(30, 45, 45, 45),
      plot.background = element_rect(fill = "#e6eaeb", color = "#e6eaeb")
    ) #+
    #ggsave(here::here("plots", "test_tinygrid.pdf"), width = 16, height = 9, device = cairo_pdf)
}

ggmouse_art <- function(track) {

  day <- Sys.Date()

  n <- sqrt(nrow(track)) # / 10000

  art <- data.frame(
    x = runif(n, min(track$x, na.rm = TRUE) + 50,
                 max(track$x, na.rm = TRUE) - 50),
    y = runif(n, min(track$y, na.rm = TRUE) + 50,
                 max(track$y, na.rm = TRUE) - 50),
    r = runif(n, 1, 100),
    s = factor(sample(1:2, n, replace = TRUE)),
    c = factor(sample(1:4, n, replace = TRUE))
  )

  ggplot(track, aes(x, y)) +
    geom_path(color = "grey60") +
    geom_point(
      data = art,
      aes(color = c, size = r, shape = s),
      stroke = .6
    ) +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_color_manual(
      values = c("#cc0000", "#ff996e", "#00bae2", "#ede9d0"),
      guide = "none"
    ) +
    scale_size(
      range = c(1, 10),
      guide = "none"
    ) +
    scale_shape_manual(
      values = c(16, 1),
      guide = "none"
    ) +
    theme_void() #+
    #ggsave(here::here("plots", "test_art.pdf"), width = 16, height = 9, device = cairo_pdf)
}

ggmouse_art_bw <- function(track) {

  day <- Sys.Date()

  n <- sqrt(nrow(track)) # / 10000

  art <- data.frame(
    x = runif(n, min(track$x, na.rm = TRUE) + 50,
              max(track$x, na.rm = TRUE) - 50),
    y = runif(n, min(track$y, na.rm = TRUE) + 50,
              max(track$y, na.rm = TRUE) - 50),
    r = runif(n, 1, 100),
    s = factor(sample(1:2, n, replace = TRUE)),
    c = runif(n, 1, 10)
  )

  ggplot(track, aes(x, y)) +
    geom_path(color = "grey60") +
    geom_point(
      data = art,
      aes(color = c, size = r, shape = s),
      stroke = .6
    ) +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_color_gradient(
      low = "grey95",
      high = "grey30",
      guide = "none"
    ) +
    scale_size(
      range = c(1, 10),
      guide = "none"
    ) +
    scale_shape_manual(
      values = c(16, 1),
      guide = "none"
    ) +
    theme_void() #+
    #ggsave(here::here("plots", "test_art_bw.pdf"), width = 16, height = 9, device = cairo_pdf)
}
