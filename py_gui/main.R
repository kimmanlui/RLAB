
if (!exists("main_ENV.R")) source("main_ENV.R")

batch=getBatch()
vl.org=NULL 

vl.org=tryCatch({
  getPrice()
}, warning = function(w) {  NULL
}, error = function(e)   {  print(paste(Sys.time()," Error : calling getprice")) 
})

hsi=round(as.numeric(vl.org[3])) %% 1000
text=paste0(batchToStamp(vl.org[2])," ",hsi )
print(text)
          
displayQueue(text)

