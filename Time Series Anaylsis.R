#Load Data
AirPassengers

#Basic statistics

class(AirPassengers)

start(AirPassengers)

end(AirPassengers)

summary(AirPassengers)

#Visualitzations

plot(AirPassengers)    #non stationary

#Linear Model

abline(lm(AirPassengers ~ time(AirPassengers)))

#show components TSA

plot(decompose(AirPassengers)) 

boxplot(AirPassengers ~cycle(AirPassengers))

#The data is not stationary

#Solve this problem

#ARIMA Model 

plot(AirPassengers)

plot(log(AirPassengers))

#Transformation by log to make variance Equal
abline(lm(log(AirPassengers) ~ time(AirPassengers)))

#Mean constatnt by differencing

plot(diff(AirPassengers))

abline(lm(diff(log(AirPassengers)) ~ time(diff(log(AirPassengers)))))


#Build Arima Model

# AR  I   MA
# p   d   q

?arima
#--------------------------
# Find value of q
acf(diff(log(AirPassengers)))

# 1-  We have to find the first inverted line 
# 2- to get Q the previous line before the first inverted line 

# q = 1
#--------------------------
# Find value of p

pacf(diff(log(AirPassengers)))

# p = 0

#--------------------------
# Find value of d

#d= 1  because we use diff one time

#Build Arima

pred = arima(log(AirPassengers), c(0,1,1), seasonal =  list(order=c(0,1,0), period=12))
# seasonal  0,1,0 becauses it random walk

#Predict using the model we created 

pred_10years = predict(pred,10*12) #next ten years
pred_10years

# normalize 
pred_10years_norm = 2.718^pred_10years$pred
pred_10years_norm

#Time series plot

ts.plot(AirPassengers, pred_10years_norm , log='y', lty = c(1,3), col='blue', main='Forcasted Value')

