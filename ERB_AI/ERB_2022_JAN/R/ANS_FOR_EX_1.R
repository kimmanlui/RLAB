print("learning objective: get familiar with your first R neuralnet program")
print("<<< STEP 1 >>>")
# if error, then execute the following line
# install.packages(pkgs='neuralnet')

library(package='neuralnet')

print("<<< STEP 2 >>>")
rawdata = "
 age , smoking, cancer
 35  ,  0 , 0
 40  ,  1 , 0
 45  ,  0 , 1
 55  ,  1 , 1"

trainData = read.csv(text=rawdata , header=TRUE)

print(trainData)

print("<<< STEP 3 >>>")

model=neuralnet(formula       =  cancer~age+smoking  ,
                data          =  trainData           , 
                hidden        =  3                   ,
                stepmax       =  1e+05               , 
                act.fct       = "logistic"           ,
                linear.output = FALSE                )
print("<<< STEP 4 >>>")
#plot(model)

print("<<< STEP 5 >>>")
predictData=compute(model, data.frame(age=50, smoking=1))
print(predictData)
print("<<< END >>>")