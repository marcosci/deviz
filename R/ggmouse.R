# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

ggmouse <- function(){

  library(readr)
  library(ggplot2)

  mouse <- read_table2("~/Downloads/mouse.txt",
                       col_names = c("x", "y"))

  day <- Sys.Date()

  ggplot(mouse, aes(x,y)) +
    geom_path(color = "#fba298", alpha = .4) +
    theme_void() +
    expand_limits(x = 0, y = 0) +
    labs(title = day, x = NULL, y = NULL) +
    theme(
      plot.title = element_text(size = 15,
                                vjust = -2,
                                hjust = -1,
                                face = "bold"),
      plot.background = element_rect(fill = "#e6eaeb", color = "#e6eaeb"),
    )


}


