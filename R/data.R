#' Computer mouse movement data
#'
#' A dataset containing the x and y coordinates of a 20 minute
#' session of one of the authors on a 3.840 x 2.160 Pixel
#' screen.
#'
#' @format A data frame with 14,251 rows and 8 variables:
#' \describe{
#'   \item{button}{Left or right button on the mouse}
#'   \item{date}{Date and time of event}
#'   \item{dx}{Scrollevent, Movement on the x axis}
#'   \item{dy}{Scrollevent, Movement on the y axis}
#'   \item{pressed}{TRUE, where the button was pressed and False where the button was released}
#'   \item{type}{Type of mouse event}
#'   \item{x}{Coordinate on x-axis of the screen}
#'   \item{y}{Coordinate on y-axis of the screen}
#' }
"mouse_df"

#' Keyboard stroke data
#'
#' A dataset containing the x and y coordinates of a 20 minute
#' session of one of the authors on a 3.840 x 2.160 Pixel
#' screen.
#'
#' @format A data frame with 14,251 rows and 8 variables:
#' \describe{
#'   \item{key}{Pressed key}
#'   \item{date}{Date and time of event}
#' }
"key_df"
