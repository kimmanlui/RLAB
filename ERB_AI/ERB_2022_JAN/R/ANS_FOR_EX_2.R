print("handwritten digital recognition problem")
print("<<< STEP 1 >>>")
#install.packages('neuralnet')
#install.packages('dplyr')
#install.packages("remotes")
#remotes::install_github('stillmatic/MNIST', force=TRUE)

library(neuralnet)
library(MNIST)
library(dplyr)

print("<<< STEP 2 >>>")
class(mnist_train)

nrow(mnist_train)  # how many records 60000
ncol(mnist_train)  # how many features
head(colnames(mnist_train))

print("<<< STEP 3 >>>")
showImage = function(data, row_index){
  #Obtaining the row as a numeric vector
  r = as.numeric(data[row_index, 1:784])
  
  #Creating a empty matrix to use
  im = matrix(nrow = 28, ncol = 28)
  
  #Filling properly the data into the matrix
  j = 1
  for(i in 28:1){
    im[,i] = r[j:(j+27)]
    j = j+28
  }  
  
  #Plotting the image with the label
  image(x = 1:28, 
        y = 1:28, 
        z = im, 
        col=gray((0:255)/255), 
        main = paste("Number:", data[row_index, 'y']))
}

print("<<< STEP 4 >>>")
# we have 60000 and we select the third one
useWhichIndex = 3

print("<<< STEP 5 >>>")
print(mnist_train[ useWhichIndex , ])
showImage(mnist_train, row_index= useWhichIndex )

print("<<< STEP 6 >>>")
print("show the label")
print(head(mnist_train$y))


print("<<< STEP 7 >>>")
inds <- nnet::class.ind(mnist_train$y)
head (inds)
str(inds[ useWhichIndex ,])

print("<<< STEP 8 >>>")
colnames(inds) <- paste("val", colnames(inds), sep = "")
#pf=paste(paste(colnames(inds), collapse = "+"), " ~ ", 
#                      paste(names(MNIST::mnist_train)[1:784], collapse = "+") )
hpf=paste(paste(colnames(inds), collapse = "+"), " ~ .")
f = formula(hpf)
print(f)

print("<<< STEP 9 >>>")
indsdf=data.frame(inds)
trainData = cbind(mnist_train[, 1:784], indsdf)
nrow(trainData)
trainData=trainData[1:400, ]
nrow(trainData)

print("<<< STEP 10 >>>")
ncol(trainData)
colnames(trainData)

print("<<< STEP 11 : Training ...>>>")
model = neuralnet(formula=f, 
                  data = trainData, 
                  hidden = c(5), 
                  stepmax=  1e+05   , 
                  act.fct='logistic',
                  linear.output = FALSE)

print("<<< STEP 12 >>>")
selectIndex=5

print("We selected the image index")
print("selectIndex")
print("The label of this image is :")
print(mnist_test[ selectIndex , 'y'])

print("<<< STEP 13 >>>")
preds <- neuralnet::compute(model, mnist_test[ selectIndex , 1:784])

print("<<< STEP 14 >>>")
print("NN Classification")
print(preds$net.result)

print("<<< END >>>")