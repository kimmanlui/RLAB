
rm(list = ls(all = TRUE))  


source('c:/kim/gitdir/RLAB/demo_mongolite/mongo_lib.R')




checkIfSendEmail=function(msg, res=NULL)
{
  require(mongolite)
  require(jsonlite)
  FlagSendMail=FALSE
  FlagLastStatus=FALSE
  FlagSendTime=FALSE
  mg <- mongo(collection = "CHECK_MRT")
  # mg$drop()
  # mg$find()
  if (res==TRUE){
      print(paste("input res: ", res))
      retV=updateMongo('msg', msg, 'status', as.character(res), mg)
      if ( (retV[[1]]+retV[[2]]+retV[[3]]) ==0)  insertMongo("msg", msg,"status", res, mg)
  } else
  {
    print(paste("input res: ", res))
    lastmg=findMongo('msg', msg, mg)
    print("lastmg")
    print(lastmg)
    if (lastmg[1,'status']=='TRUE') FlagLastStatus=TRUE
    updateMongo('msg', msg, 'status', as.character(res), mg)
    if ( as.numeric(format(Sys.time(),"%H"))  %in% c(7,12,18,23) ) FlagSendTime=TRUE
    if (FlagLastStatus==TRUE ) FlagSendMail=TRUE
    else if (FlagLastStatus==FALSE && FlagSendTime==TRUE) FlagSendMail=TRUE
  }
  updateMongo('msg', msg, 'last_upd_date', as.character(Sys.time()), mg)
  
  print(paste('msg', 'res', 'FlagLastStatus', 'FlagSendTime', 'FlagSendMail'))
  print(paste(msg, res, FlagLastStatus, FlagSendTime, FlagSendMail))
  return(FlagSendMail)
}  

library(XML)
xmlData <- xmlParse("/kim/conf.xml")
confData <- xmlToList(xmlData)
chkweb_topeople_hot =confData[['chkweb_topeople_hot']]
chkweb_topeople_team=confData[['chkweb_topeople_team']]

library(httr)
library(RCurl)
library(rvest)
source('C:/kimman/prj/myR/SUPPORT_LIB.R')
dat=data.frame(  url=c("http://99.myftp.org" , "http://js55.myftp.org" ) , 
                 sig=c("shine"               , "permission"            ) , 
                 msg=c('99'                  , "js55"                  ) ,
                 stringsAsFactors = FALSE)

dat=rbind(dat, data.frame(url="http://10.203.68.23:8080/sbmvnoapp/login.html" , sig="Forgot Password",  msg='rhmvno01'))
dat=rbind(dat, data.frame(url="http://10.203.68.24:8080/sbmvnoapp/login.html" , sig="Forgot Password",  msg='rhmvno02'))
dat=rbind(dat, data.frame(url="http://10.203.68.26:8080/sbmvnoapp/login.html" , sig="Forgot Password",  msg='rhmvno04'))
dat=rbind(dat, data.frame(url="http://10.212.1.8:8080/sbmvnoapp/login.html"   , sig="Forgot Password",  msg='rhmvnoa3'))


for (i in 1: nrow(dat))
{
  #i=6
   url=dat[i,'url']
   sig=dat[i,'sig']
   msg=dat[i,'msg']
   print(i)
   
   doc=tryCatch(
     getURL(url), error=function(cond) {NULL}, warning=function(cond) {NULL}
   )
   
   doc=read_html(doc)
   res=FALSE
   if (!is.null(doc))
   {
     doch = doc %>% html_nodes("body") %>% html_text()
     res=grepl( sig, doch, fixed = TRUE)
   } 
    
   
   #if (res==FALSE)
   if (checkIfSendEmail(msg  , res))   
   {
     subject=paste0("Web Reachability Problem: ", msg  )
     print(subject)
     
     print("Send Email Notification")
     temp=runSendMailBody(email=chkweb_topeople_hot , subject=subject, body=subject, from='checkWebSite')
     if (i>=3)
     {
       temp=runSendMailBody(email=chkweb_topeople_team , subject=subject, body=subject, from='checkWebSite')
     }
   }
}