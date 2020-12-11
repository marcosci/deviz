#' import_mouse
#'
#' @param file Path and filename, file format must currently be ".txt"
#'
#' @return
#' @export
#'
#' @examples
#' \donttest{
#' import_mouse("data/test.txt")
#' }
import_mouse <- function(file) {

  mouse <- utils::read.table(file, quote = "\"", comment.char = "")
  colnames(mouse) <- c("x", "y")
  return(mouse)

}
