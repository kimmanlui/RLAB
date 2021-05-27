rm(list = ls(all = TRUE)) 

require(XML)
xmlData <- xmlParse("/kim/conf.xml")
confData <- xmlToList(xmlData)

rootDirR="/kim/gitdir/RLAB/Price/"
source('/kim/gitdir/RLAB/common/From_util.R')
source('/kim/gitdir/RLAB/common/JDBC_MYSQL.R')

source( paste0(rootDirR, "et_LIB.R") )
source( paste0(rootDirR, "dailyData.R") )
source( paste0(rootDirR, "dailyData_LIB.R") )

batchToStamp=function(x)  return ( (x%/%60+9)*100+(x%%60) )

displayQueue=function(x)
{
  fileConn<-file("../../content.txt")
  writeLines(as.character(x), fileConn)
  close(fileConn)
}

startTime =0921
startLunch=1202
endLunch  =1259
endTime   =1602

stamp=as.character(format(Sys.time(),"%H%M" ))
istamp=as.numeric(stamp)
firsttime=1

while(1==1)
{
  
  dayOfWeek=weekdays(Sys.Date())
  dweek=!(dayOfWeek=='Sunday' || dayOfWeek=='Saturday')
   
  if (dweek)
  {
    while (firsttime==1 || startTime<=istamp && istamp<endTime)
    {
      if ( firsttime==1 || (startTime<=istamp && istamp<=startLunch) ||  (endLunch<=istamp && istamp<endTime) )
      {
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

          firsttime=firsttime+1
      }  
         
      istamp=as.numeric(as.character(format(Sys.time(),"%H%M" )))
      oldsec=as.numeric(as.character(format(Sys.time(),"%S" )))
      if (oldsec==0)
      {
          Sys.sleep(1)
          oldsec=as.numeric(as.character(format(Sys.time(),"%S" )))
      }
      newsec=as.numeric(as.character(format(Sys.time(),"%S" )))
          
      print('..')
      while( newsec>=oldsec)
      {
         Sys.sleep(1)
         newsec=as.numeric(as.character(format(Sys.time(),"%S" )))
      }
      
    }
  }
}
