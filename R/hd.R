#' hd
#'
#' @param varresult
#' @param plot
#' @param plot_res
#'
#' @importFrom data.table .I .N .SD :=
#'
#' @return
#' @export
hd = function(
  varresult,
  plot = T,
  plot_res = T
)

{

  # Get outputs ----
  data = data.table::as.data.table(varresult$data)
  constant = varresult$constant # boolean
  const = ifelse(constant, 1, 0)
  lag = varresult$lag
  A = varresult$A
  A_comp = varresult$A_comp
  K = varresult$K
  df = varresult$df
  Sigma_res = varresult$Sigma_res
  var_names = varresult$var_names
  N = varresult$N
  u = varresult$res
  Y = varresult$Y

  # Step 1 - compute structural coefficient matrices: ----
  Phi = red_ir(lag, K, A_comp, const, n.ahead=N)
  B_0 = identify_chol(Sigma_res)
  Theta = compute_Theta(Phi, B_0)

  # Step 2 - compute the structural shocks: ----
  w = u %*% t(B_0)

  # Step 3 - match structural shocks with appropriate impulse response weight: ----
  y_hat_dt = data.table::rbindlist(
    lapply(1:N, function(t) { # loop over time periods
      terms_to_sum = lapply(1:t, function(s) {
        sapply(1:K, function(k) Theta[[s]][k,] * w[t-s+1,])
      })
      y_hat_t = Reduce(`+`, terms_to_sum)
      colnames(y_hat_t) = var_names
      y_hat_t = data.table::as.data.table(t(y_hat_t))[,c("k","t"):=.(var_names, t)]
      return(y_hat_t)
    })
  )[order(k,t)]

  # Step 4 - tidy up: ----
  y_hat_dt[,actual:=detrend(Y[,k]),by=k]
  y_hat_dt[,fitted:=rowSums(.SD),.SDcols=var_names]
  y_hat_dt[,residual:=actual-fitted]

  # Plot ----
  if (plot==T) {
    chart_data = data.table::melt(y_hat_dt, measure.vars = c("residual", var_names))
    if (plot_res==T) {
      p = ggplot2::ggplot(chart_data) +
        ggplot2::geom_col(ggplot2::aes(x=t, y=value, fill=variable)) +
        ggplot2::geom_line(ggplot2::aes(x=t, y=actual)) +
        ggplot2::facet_wrap(k ~ .)
      p
    } else {
      p = ggplot2::ggplot(chart_data[variable!="residual"]) +
        ggplot2::geom_col(ggplot2::aes(x=t, y=value, fill=variable)) +
        ggplot2::geom_line(ggplot2::aes(x=t, y=fitted)) +
        ggplot2::facet_wrap(k ~ .)
      p
    }
  }


}