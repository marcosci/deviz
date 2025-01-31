% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clean_keyboard.R
\name{clean_keyboard}
\alias{clean_keyboard}
\title{Clean key tracking data}
\usage{
clean_keyboard(keys, ggkeyboard = ggkeyboard::tkl)
}
\arguments{
\item{keys}{A data.frame with data tracked by \code{\link{track_keyboard}}}

\item{ggkeyboard}{An input keyboard from \code{\link{ggkeyboard}}.}
}
\description{
Adds a heatmap about how often a key was pressed on keyboard from \code{\link{track_keyboard}}
}
\examples{
clean_keyboard(key_df, ggkeyboard = ggkeyboard::mac)

}
