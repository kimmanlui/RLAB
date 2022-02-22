
rm(list = ls(all = TRUE))  


library(RCurl)
library(XML)
library(rvest)
require(XML)

print(paste("before source"))
source('/kim/gitdir/RLAB/common/From_util.R')
source('/kim/gitdir/RLAB/common/JDBC_MYSQL.R')
myConn=conn
myconn=conn
test=FALSE

print(paste("before getETQuote"))

getETQuote = function() {
  date=Sys.Date()
  batch=getBatch()
  base_url <- "http://www.etnet.com.hk/www/eng/futures/index.php"
  doc <- read_html(base_url)
  a = doc %>% html_nodes("div span") %>% 
    html_text()
  mydata <- doc %>%
    html_nodes("td") %>%
    html_text()
  b=data.frame(t(gsub(",","",mydata[c(3,5,7,9,11,13,15,17,19)])))
  retV = data.frame(hsi=as.numeric(gsub(",", "", a[10])))
  retV = cbind(date, batch, retV, b)
  if (is.na(retV[3])) retV[1]=0
  return (retV)
  #return(as.character(format(Sys.time(),"%X" )), retV)
}


print(paste("before test"))
dailyHSI=NULL
if (test==TRUE)
{
  vl.org=getETQuote()
  vl=substrRight(round(vl.org[3],0),3)
  ssec.org=getSSEC()[2]
  names(ssec.org)="sh"
  vl.org=cbind(vl.org, ssec.org)
  ssec=substrRight(round(ssec.org,0),2)
  
  tempHSI=data.frame(date=Sys.time(),hsi=vl,ssec=ssec)
  dailyHSI=rbind(dailyHSI,tempHSI)
  vl.org$X6=0
  
  print(paste(vl,ssec,as.character(format(Sys.time(),"%H%M:%S" ))))
  insertDataFrame(myConn, vl.org, c("c", "n", "c", rep("n",8),"c","n" ), "et" )
  print("====test done====")
}


dailyHSI=NULL
print(paste("start at:", format(Sys.time())))
end_interval=999999
for (i in 1:end_interval) {
  # i = 1 
  if ( (format(Sys.time(), "%M")>=22 && as.numeric(format(Sys.time(), "%H"))==9) ||
       (format(Sys.time(), "%H") >=10) &&
       (format(Sys.time(), "%H") != 12) && 
       (format(Sys.time(), "%H") < 16)) {
    
    
    
    wakeUp(fromSec=40, toSec=45)
    
    
    
    vl.org=tryCatch({
      getETQuote()
    }, warning = function(w) {  NULL
    }, error = function(e)   {  print(paste(Sys.time(),"Error : calling getETQuote")) 
    })
    
    if (length(vl.org)<=1)
    {
      Sys.sleep(25)
      next; 
    }
    
    vl=substrRight(round(vl.org[3],0),3)
    #ssec.org=getSSEC()[2]
    #names(ssec.org)="sh"
    ssec.org=111
    vl.org=cbind(vl.org, ssec.org)
    #ssec=substrRight(round(ssec.org,0),2)
    ssec=111
    
    tempHSI=data.frame(date=Sys.time(),hsi=vl,ssec=ssec)
    dailyHSI=rbind(dailyHSI,tempHSI)
    vl.org$X6=0
    
    stamp=as.character(format(Sys.time(),"%H%M" ))
    print(paste(vl,ssec,as.character(format(Sys.time(),"%H%M:%S" ))))
    if (stamp=="0929") print("===== ===== =====")
    
   
    tryCatch({
      insertDataFrame(myConn, vl.org, c("c", "n", "c", rep("n",8),"c","n" ), "et" )
    }, warning = function(w) {  NULL
    }, error = function(e)   {  print(paste(Sys.time(),"Error : calling insertDataFrame")) 
    })
    
    
  }
  
  Sys.sleep(25)
  
  batch=as.numeric(format(Sys.time(), "%H%M"))
  if (batch >= 1605) {  print("schedule break after 1605"); break; }
}

#save (dailyHSI, file="dailyHSI0928.RData")


#CREATE TABLE  et (
#  date VARCHAR(255)  NOT NULL,
#  batch int NOT NULL,
#  hsi  VARCHAR(255) NULL  ,
#  X1  decimal(10,4) NULL  , X2  decimal(10,4) NULL  , X3  decimal(10,4) NULL  , X4  decimal(10,4) NULL  ,
#  X5  decimal(10,4) NULL  , X6  decimal(10,4) NULL  , X7  decimal(10,4) NULL  , X8  decimal(10,4)NULL  ,
#  X9 decimal(10,4) NULL  ,
#  sh  VARCHAR(255) NULL ,
#  PRIMARY KEY(date, batch)
#)  
