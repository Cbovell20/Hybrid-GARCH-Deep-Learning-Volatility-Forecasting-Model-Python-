# Hybrid-GARCH-Deep-Learning-Volatility-Forecasting-Model-Python-
A comparative framework integrating econometric volatility models with deep learning architectures to improve short-horizon financial volatility forecasting.


# Overview

This project develops and evaluates a hybrid volatility forecasting system that combines traditional econometric models (GARCH-family) with deep learning architectures (LSTM/DNN). The goal is to determine whether alternative data and nonlinear sequence models can meaningfully improve out-of-sample volatility predictions relative to standard benchmarks.

The framework is applied to S&P 500 / SPX returns, using:
- Sentiment data (Reddit-based NLP scores)
- Market-based indicators (VIX)
- Macroeconomic variables (selected FRED series)

The project was completed as part of an advanced econometrics research initiative (Econ 423), incorporating both theoretical and applied quantitative finance components.

# Models Implemented
Econometric Models
- AR(1)–GARCH(1,1)
- GARCH-X (exogenous regressors: sentiment, VIX, macro series)
- Normal and skew-t innovations

# Deep Learning Models
- LSTM
- DNN 
- Dense hybrid model combining GARCH residuals + deep features

# Hybrid Model Construction
The hybrid architecture integrates:
- GARCH conditional variance estimates
- Deep learning forecasts of nonlinear volatility patterns
- Feature sets including sentiment, VIX, and macroeconomic signals

Final predictions are generated using weighted or learned combinations of both components.

# Data Sources
- SPX daily returns — Yahoo Finance
- VIX index — CBOE
- Macroeconomic indicators — FRED API
- Reddit sentiment — Custom NLP pipeline using VADER + post filtering

All data is cleaned and aligned using robust timestamp-based merging with lag structures appropriate for forecasting.

# Key Results
- The hybrid GARCH–LSTM approach improves predictive accuracy compared to standard econometric baselines.
- Out-of-sample evaluation shows stronger performance in periods with nonlinear volatility clustering.
- Incorporating sentiment and macro indicators improves tail-risk recognition and produces more responsive volatility estimates.
- Diagnostic plots and evaluation metrics (RMSE, MAE, QLIKE) demonstrate clear performance enhancements.

<img width="339" height="135" alt="Final comparision for deep learning" src="https://github.com/user-attachments/assets/ea6f4a62-902c-4788-a9ac-167c60dfba77" />


# Technologies & Libraries
- Python
- NumPy, Pandas
- Statsmodels (GARCH)
- TensorFlow / Keras
- Scikit-learn
- Matplotlib / Seaborn
- NLTK / VADER
