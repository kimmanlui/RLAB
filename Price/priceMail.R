

require(XML)
xmlData <- xmlParse("/kim/conf.xml")
confData <- xmlToList(xmlData)

source('/kim/gitdir/RLAB/common/From_util.R')
source('/kim/gitdir/RLAB/common/JDBC_MYSQL.R')



getLatest=function()
{
  retV=dbGetQuery(conn, "select * from et order by date , batch desc  LIMIT 1 ")
  return(retV)
}



library("reticulate")
use_python("/programdata/anaconda3", required = T)
py_config()
rootDirR="/kim/gitdir/RLAB/Price/"
source_python("/kim/gitdir/RLAB/Outlook/outlook_LIB.py")

#outlookMail('TEST_MAIL', 'TEST')

source( paste0(rootDirR, "et_LIB.R") )
source( paste0(rootDirR, "dailyData.R") )

dailyHSI=NULL
print(paste("start at:", format(Sys.time())))
stamp=as.character(format(Sys.time(),"%H%M" ))
istamp=as.numeric(stamp)
#wakeUp(fromSec=35, toSec=40)
firsttime=1
dailyData=NULL
fileName=paste0('/kim/data/Data',Sys.Date())
if (file.exists(fileName))
{
  load(fileName)
} else
{
  dailyData=NULL
}

startTime =0921
startLunch=1202
endLunch  =1259
endTime   =1602
while(1==1)
{

  if (istamp==startTime)  source( paste0(rootDirR, "dailyData.R") )
    
  
  dayOfWeek=weekdays(Sys.Date())
  dweek=!(dayOfWeek=='Sunday' || dayOfWeek=='Saturday')
  if (dweek)
  {
    while (firsttime==1 || startTime<=istamp && istamp<endTime)
    {
      if ( firsttime==1 || (startTime<=istamp && istamp<=startLunch) ||  (endLunch<=istamp && istamp<endTime) )
      {
        batch=getBatch()
        
        vl.org=tryCatch({
          getLatest()
        }, warning = function(w) {  NULL
        }, error = function(e)   {  print("Error : calling getLatest") 
        })
        
        
        
      #  vl.org=tryCatch({
      #    getETQuote()
      #  }, warning = function(w) {
      #    NULL
      #  }, error = function(e) {
      #    print("Error : calling getBatch")
      #  })
       
        
   
        if (!is.null(vl.org))
        {
          mins=as.numeric(as.character(format(Sys.time(),"%M" )))
          ish=round( as.numeric(vl.org[3]) ,0)
          vl=substrRight(ish,3)
          vl.org['sh']=round(  as.numeric(vl.org['sh'])  ,0)
          #ssec.org=getSSEC()[2]
          #names(ssec.org)="sh"
          #vl.org=cbind(vl.org, ssec.org)
          ssec.short=substrRight(round(  as.numeric(vl.org['sh']) ,0),2)
          dbBatch=vl.org['batch']
          tempData=data.frame(date=Sys.Date(),batch=vl.org['batch'], stamp=batchToStamp(batch) , hsi=ish, ssec=as.numeric(vl.org['sh']))
          dailyData=rbind(dailyData,tempData)
          vl.org$X6=0
           
          fileName=paste0('/kim/data/Data',Sys.Date())
          save(dailyData, file=fileName)
        }
        
        print(as.numeric(vl.org[3])) #stockV
        
        body='NA'
        body=tryCatch({
          getBound(as.numeric(vl.org[3]))
        }, warning = function(w) {
          NULL
        }, error = function(e) {
          print("Error : calling getBound")
        })
        print(paste0('body:',body))
        
        body_current_V_bound='NA'
        body_current_V_bound=tryCatch({
          getRecentBound_for_V(as.numeric(vl.org[3]))
        }, warning = function(w) {
          NULL
        }, error = function(e) {
          print("Error : calling getRecentBound_for_V")
        })
        body_current_V_bound=paste0(body_current_V_bound, collapse=", ")
        print(paste0('body_current_V_bound:',body_current_V_bound))
        
        body2='NA'
        body2=tryCatch({
          getRecentBound()
        }, warning = function(w) {
          NULL
        }, error = function(e) {
          print("Error : calling getRecentBound")
        })
        body=paste0(body,'\n\n',body_current_V_bound,'\n\n',body2)
        
        if (mins %% 2==0 || firsttime==1)
        {
          tail=''
          if (mins==0 || mins==30 || mins==1 || mins==31) tail=' ------'
          if (mins==10 || mins==20 || mins==40 || mins==50 || mins==11 || mins==21 || mins==41 || mins==51 ) tail=' ...'
          cmin=paste0('00',mins)
          cmin=substr(cmin,nchar(cmin)-1,nchar(cmin))
          Subject=paste0('CELLRPT ',batchToStamp(dbBatch) ,  ": ",vl,' / ',ssec.short,tail )
          
          body=tryCatch({
            outlookMail(Subject, body , to=confData[['to']] ,  rootFolderName=confData[['rootFolderName']])
          }, warning = function(w) {
            NULL
          }, error = function(e) {
            print("Error : calling outlookMail")
          })
          
          
        } else
        {
          print('.')
        }
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
  } # dweek
  istamp=as.numeric(as.character(format(Sys.time(),"%H%M" )))
  Sys.sleep(60)
}