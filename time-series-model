##时间序列分析
#生成时序对象
sales<-c(18,33,41,7,34,35,24,25,24,21,25,20,
         22,31,40,29,25,21,22,54,31,25,26,35)
tsales<-ts(sales,start = c(2003,1),frequency = 12)
plot(tsales)

##通过简单移动平均绘制平滑曲线
install.packages("forecast")
library(forecast)
opar<-par(no.readonly = TRUE)##可以生成一个可以修改的当前图形参数列表
par(mfrow=c(2,2))
ylim<-c(min(Nile),max(Nile))
plot(Nile,main="Raw time series")
plot(ma(Nile,3),main="k=3 time series",ylim=ylim)
plot(ma(Nile,7),main="k=7 time series",ylim=ylim)
plot(ma(Nile,15),main="k=15 time series",ylim=ylim)
par(opar)

##季节性分解
plot(AirPassengers)
logairpassengers<-log(AirPassengers)
plot(logairpassengers,ylab="logairpassengers")
fit<-stl(logairpassengers,s.window = "period")
plot(fit)

#季节分解可视化
par(mfrow=c(2,1))
library(forecast)
monthplot(AirPassengers,xlab="",ylab="")
seasonplot(AirPassengers,year.labels = TRUE,main = "")

##指数预测模型
#单指数预测模型
library(forecast)
fit<-ets(nhtemp,model = "ANN")
forecast(fit,1)  ##一步向前预测
par(mfrow=c(2,2))
plot(forecast(fit,1))
plot(forecast(fit,2))
plot(forecast(fit,3))
plot(forecast(fit,4))

##Holt-Winters指数平滑预测模型
library(forecast)
fit<-ets(log(AirPassengers),model = "AAA")
accuracy(fit)
#对未来五个月进行预测
pred<-forecast(fit,5)
plot(pred)

##ARIMA模型
library(forecast)
library(tseries)
plot(Nile)

#对Nile数据进行一次拆分
diff(Nile,1)
plot(diff(Nile,1))

##使用ndiffs函数求最佳拆分模式
ndiffs(Nile)
dNile <- diff(Nile)
plot(dNile)
adf.test(dNile)

##选择模型
par(mfrow=c(2,1))
Acf(dNile)
Pacf(dNile)
par(opar)

##拟合ARIMA模型
library(forecast)
fit <- arima(Nile,order = c(0,1,1))

##模型评价
qqnorm(fit$residuals)
qqline(fit$residuals)
Box.test(fit$residuals,type = "Ljung-Box")

##用ARIMA模型进行预测
forecast(fit,3)
plot(forecast(fit,3),xlab = "Year",ylab = "Annual flow")

##ARIMA模型进行自动预测
library(forecast)
fit <- auto.arima(sunspots)
forecast(fit,3)
accuracy(fit)
plot(fit)
