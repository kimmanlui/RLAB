print("solving diabetic classification problem")
print("<<< STEP 1 >>>")
url='https://raw.githubusercontent.com/MicrosoftLearning/mslearn-dp100/main/data/diabetes.csv'
df=read.csv(url ,header=TRUE)

print("<<< STEP 2 >>>")

myNorm=function(x)  (x - min(x)) / (max(x) - min(x)) 

print("<<< STEP 3 >>>")
df.n=df[, c(2,3,4,5,6,7,8,9,10) ]

print("<<< STEP 4 >>>")
df.n[ , 1] = (df[ , 1]- min(df[ , 1])) / (max(df[ , 1])-min(df[ , 1]))
#or 
df.n[ , 1] = myNorm(df.n[ , 1])
df.n[ , 2] = myNorm(df.n[ , 2])

for (i in 1:9)
{
   print(i)
}

for (i in 1:9)
{
   df.n[ , i] = myNorm(df.n[ , i])
}

head(df.n)

print("<<< STEP 5 >>>")
print(colnames(df.n))
f = 'Diabetic~Pregnancies+PlasmaGlucose+DiastolicBloodPressure+TricepsThickness+SerumInsulin+BMI+DiabetesPedigree+Age'
print(f)

print("<<< STEP 6 >>>")
rows  = sample(nrow(df.n))
print(rows)
df.ns = df.n[rows, ]
df.ns.train=df.ns[1   :700 , ]
df.ns.test=df.ns[700:1000 , ]

print("<<< STEP 7 >>>")
library(neuralnet)

print("<<< STEP 8 >>>")
model = neuralnet(formula=f, 
                  data   = df.ns.train, 
                  hidden = c(10,10)   , 
                  stepmax=  1e+05   , 
                  act.fct='logistic',
                  linear.output = FALSE)

print("<<< STEP 9 >>>")
#plot(model)

print("<<< STEP 10 >>>")
result=data.frame(predict=predict(model, df.ns.test[,c(2,3,4,5,6,7,8,9)]) , 
           actual=df.ns.test$Diabetic)
print(result)

print("<<< STEP 11 >>>")
result[ , 'predict'] =round(result[  , 'predict'],0)
print(result)

print("<<< STEP 12 >>>")
accuracy = sum(result$predict == result$actual) / nrow(result)
print(":: accuracy :: ")
print(accuracy)
print("<<< END >>>")