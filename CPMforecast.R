# https://facebook.github.io/prophet/docs/quick_start.html#r-api
library(prophet)



# e.g. ds : date and y: Facebook CPM to see seasonality, prices on Black Friday etc
df <- read.csv('')

# Dataframe must have columns 'ds' and 'y' with the dates and values respectively.
colnames(df) <- c("ds","y")

##################
# Without holidays
# We call the prophet function to fit the model
m <- prophet(df)

# Predictions are made on a dataframe with a column ds 
# containing the dates for which predictions are to be made.

# The make_future_dataframe function takes the model 
# object and a number of periods to forecast and produces a suitable dataframe. 
# By default it will also include the historical dates so we can evaluate in-sample fit.
future <- make_future_dataframe(m, periods = 365)
tail(future)


# we use the generic predict function to get our forecast. 
# The forecast object is a dataframe with a column yhat containing the forecast. 
# It has additional columns for uncertainty intervals and seasonal components.

forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

# You can use the generic plot function to plot the forecast,
# by passing in the model and the forecast dataframe.
plot(m, forecast)

# You can use the prophet_plot_components function to see 
# the forecast broken down into trend, weekly seasonality, and yearly seasonality.
prophet_plot_components(m, forecast)


################3
# With holidays
# include holidays
m <- prophet(daily.seasonality=TRUE)
m <- add_country_holidays(m, country_name = 'US')
m <- fit.prophet(m, df)

# You can see which holidays were included:
m$train.holiday.names


# Predictions are made on a dataframe with a column ds 
# containing the dates for which predictions are to be made.

# The make_future_dataframe function takes the model 
# object and a number of periods to forecast and produces a suitable dataframe. 
# By default it will also include the historical dates so we can evaluate in-sample fit.
future <- make_future_dataframe(m, periods = 365)
tail(future)


# we use the generic predict function to get our forecast. 
# The forecast object is a dataframe with a column yhat containing the forecast. 
# It has additional columns for uncertainty intervals and seasonal components.

forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

# You can use the generic plot function to plot the forecast,
# by passing in the model and the forecast dataframe.
plot(m, forecast)

# You can use the prophet_plot_components function to see 
# the forecast broken down into trend, weekly seasonality, and yearly seasonality.
prophet_plot_components(m, forecast)


# yearly seasonality
m <- prophet(df)
prophet:::plot_yearly(m)


