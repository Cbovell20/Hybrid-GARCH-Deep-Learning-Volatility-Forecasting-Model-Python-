

# 3. FUNCTION TO FIT GARCH-X WITH GENERIC DISTRIBUTION
fit_garchx <- function(dist_name, X, returns) {
  spec <- ugarchspec(
    variance.model = list(
      model = "sGARCH",
      garchOrder = c(1,1),
      external.regressors = X
    ),
    mean.model = list(
      armaOrder = c(1,0),
      include.mean = TRUE,
      external.regressors = X
    ),
    distribution.model = dist_name   # "norm", "std", "sstd"
  )
  ugarchfit(spec = spec, data = returns)
}

## 4. FIT ALL THREE DISTRIBUTIONS
fit_norm   <- fit_garchx("norm",  X, returns)   # Gaussian
fit_t      <- fit_garchx("std",   X, returns)   # Student‑t
fit_skewt  <- fit_garchx("sstd",  X, returns)   # Skew‑t

cat("Finished fitting norm, std, sstd.\n")

## 5. EXTRACT VOLATILITY SERIES
vol_norm  <- sigma(fit_norm)
vol_t     <- sigma(fit_t)
vol_skewt <- sigma(fit_skewt)

## 6. EXTRACT COEFFICIENTS EXAMPLE (NORMAL)
coefs_norm <- coef(fit_norm)
impact_norm <- data.frame(
  Variable = c("VIX lag 2", "M2 lag 2", "Sentiment lag 5"),
  Mean_Eq = c(coefs_norm["mxreg1"], coefs_norm["mxreg2"], coefs_norm["mxreg3"]),
  Var_Eq  = c(coefs_norm["vxreg1"], coefs_norm["vxreg2"], coefs_norm["vxreg3"])
)

write.csv(impact_norm, "garchx_impact_table_norm.csv", row.names = FALSE)

## 7. EXPORT VOLATILITIES
export_df <- data.frame(
  Date           = index(vol_norm),
  vol_norm       = as.numeric(vol_norm),
  vol_t          = as.numeric(vol_t),
  vol_skewt      = as.numeric(vol_skewt)
)
write.csv(export_df, "garchx_vol_all_dists.csv", row.names = FALSE)

## 8. PLOT ALL THREE ON ONE GRAPH
png("garchx_vol_all_dists.png", width = 1000, height = 600)
plot(vol_skewt, type = "l", col = "darkgreen",  lwd = 2,
     main = "GARCH-X Conditional Volatility: skew‑t",
     ylab = expression(sigma[t]), xlab = "Date")

legend("topright",
       legend = c("Skew‑t"),
       col = c("darkgreen"), lwd = 2, bty = "n")
dev.off()

## 9. SAVE SUMMARIES
sink("garchx_norm_summary.txt");   show(fit_norm);  sink()
sink("garchx_t_summary.txt");      show(fit_t);     sink()
sink("garchx_skewt_summary.txt");  show(fit_skewt); sink()

cat("Done fitting and saving results for norm, std, sstd.\n")
