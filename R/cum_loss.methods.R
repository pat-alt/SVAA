#' @export
plot.cum_loss <- function(cum_loss) {
  p <- ggplot2::ggplot(data = cum_loss$cum_loss, ggplot2::aes(x=date, y=value)) +
    ggplot2::geom_line() +
    ggplot2::facet_wrap(.~variable, scales = "free_y") +
    ggplot2::labs(
      x="Date",
      y="Squared error"
    )
  p
  return(p)
}

#' @export
print.cum_loss <- function(cum_loss) {
  print(cum_loss$cum_loss)
}
