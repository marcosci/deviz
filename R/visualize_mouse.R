#' track_mouse
#'
#' @param track Time format, either "99h99m99s" or "inf", see details
#' @param type Path and filename, file format must currently be ".txt"
#'
#' @details
#' visualize_mouse types
#'
#' @return A ggplot2 object
#' @export
#'
#' @import ggplot2
#'
#' @examples
#' visualize_mouse(mouse_df, "tinygrid")
#'
visualize_mouse <- function(track, type = "tinygrid") {

  day <- lubridate::format_ISO8601(track$date, precision = "ymd")

  track <- track %>% dplyr::filter(type == "Move")

  # type raw ----
  if (type == "raw"){
    p1 <- ggplot(track, aes(x, y)) +
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
      )
  }

  # type tinygrid ----
  if (type == "tinygrid"){

      m <- max(track$y, na.rm = TRUE)

      p1 <- ggplot(track, aes(x, y)) +
        stat_bin_2d(
          aes(color = ..count..),
          bins = m
        ) +
        scale_x_continuous(expand = c(0, 0)) +
        scale_y_continuous(expand = c(0, 0)) +
        rcartocolor::scale_fill_carto_c(
          palette = "SunsetDark",
          guide   = "none"
        ) +
      rcartocolor::scale_color_carto_c(
        palette = "SunsetDark",
        guide   = "none"
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
        )
    }

  # type dot ----
  if (type == "dot"){

    track$i
    gd <- 1:nrow(track)

    p1 <- ggplot(track, aes(x, y)) +
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
      )
  }

  # type heatmap ----
  if (type == "heatmap"){
    p1 <- ggplot(track, aes(x, y)) +
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
      )
  }

  # type hex ----
  if (type == "hex"){

    p1 <- ggplot(track, aes(x, y)) +
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
      )
  }

  # type grid ----
  if (type == "grid"){
    p1 <- ggplot(track, aes(x, y)) +
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
      )
  }

  # type art ----
  if (type == "art"){

    n <- sqrt(nrow(track)) # / 10000

    art <- data.frame(
      x = stats::runif(n, min(track$x, na.rm = TRUE) + 50,
                max(track$x, na.rm = TRUE) - 50),
      y = stats::runif(n, min(track$y, na.rm = TRUE) + 50,
                max(track$y, na.rm = TRUE) - 50),
      r = stats::runif(n, 1, 100),
      s = factor(sample(1:2, n, replace = TRUE)),
      c = factor(sample(1:4, n, replace = TRUE))
    )

    p1 <- ggplot(track, aes(x, y)) +
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
      theme_void()

  }

  return(p1)
}
