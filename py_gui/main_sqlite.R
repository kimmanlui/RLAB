
if (!exists("/kim/gitdir/RLAB/py_gui/main_ENV_sqlite.R")) source("/kim/gitdir/RLAB/py_gui/main_ENV_sqlite.R")

batch=getBatch()
vl.org=NULL 

vl.org=tryCatch({
  getPrice()
}, warning = function(w) {  NULL
}, error = function(e)   {  print(paste(Sys.time()," Error : calling getprice")) 
})

hsi=round(as.numeric(vl.org[3])) %% 1000
text=paste0(hsi, " ", batchToStamp(vl.org[2]))
print(text)
          
displayQueue(text)

