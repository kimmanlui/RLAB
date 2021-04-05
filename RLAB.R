# RLAB Provides a set of useful functions
# This is a branch test
# This is a branch test


getLastMonth=function(myDate=Sys.Date())
{
  curMon=toNum(months(myDate))
  if (curMon==1) lastMon=12
  lastMon=curMon-1
  dateCand=myDate-c(1:62)
  dex=sapply(dateCand, function(x)toNum(months(x)) )
  dex=dex==lastMon
  return( dateCand[dex] )
}

getThisMonth=function(myDate=Sys.Date())
{
  curMon=toNum(months(myDate))
  dateCand=myDate-c(1:62)
  dex=sapply(dateCand, function(x)toNum(months(x)) )
  dex=dex==curMon
  return( dateCand[dex] )
}
 
getDataRange=function(reqFun, data=s, myDate=Sys.Date() ) 
{
  if (is.date(index(data))) dateDex=index(data)
  else if ("date" %in% colnames(data) && is.date(data$date)) dateDex=data$date
  tempData=(data[ dateDex %in% reqFun(myDate),])[,c(2,3)]
  if (nrow(tempData)==0) return(NULL)
  retV=round(range( tempData ),0)
  return(retV)
}  

getData=function (reqFun, data = s, myDate = Sys.Date())
{
  if (is.date(index(data))) dateDex=index(data)
  else if ("date" %in% colnames(data) && is.date(data$date)) dateDex=data$date
  
  retV=data[dateDex %in% reqFun(myDate), ]
  return(retV)    
}



getLastWeek=function(myDate=Sys.Date())
{
  for (i in 1:7)
  {
    lastSun=myDate-i
    if (toNum(weekdays(myDate))<=toNum(weekdays(lastSun))) break 
  }
  return(lastSun-c(2,3,4,5,6))
}

getThisWeek=function(myDate=Sys.Date())
{
  for (i in 1:7)
  {
    lastSun=myDate-i
    if (toNum(weekdays(myDate))<=toNum(weekdays(lastSun))) break 
  }
  dayDif=as.numeric(myDate-lastSun)-1
  if (dayDif==0) return(NULL)
  return(lastSun+c(1:dayDif))
}

toNum=function(text)
{
  if (text=='Monday') return(1)
  if (text=='Tuesday') return(2)
  if (text=='Wednesday') return(3)
  if (text=='Thursday') return(4)
  if (text=='Friday') return(5)
  if (text=='Saturday') return(6)
  if (text=='Sunday') return(7)
  if (text=='January') return(1);   if (text=='February') return(2) ; if (text=='March') return(3);
  if (text=='April')   return(4);   if (text=='May')      return(5) ; if (text=='June')  return(6);
  if (text=='July')    return(7);   if (text=='August')   return(8) ; if (text=='September') return(9);
  if (text=='October') return(10);  if (text=='November') return(11); if (text=='December')  return(12);
  
}

getBound=function(x)
{
  maxnrow=nrow(sfp)
  igot=-1
  for (i in 1: (nrow(sfp)-1))
  {
    if (sfp[i,'v']<=x && x<=sfp[i+1,'v'])
    {
      igot=i
      break
    }  
  }
  if (igot==-1)
  {
    if (x>sfp[nrow(sfp),'v']) {igot=nrow(sfp)}
    if (x<sfp[1,'v']) {igot=0}
    
  }

  getvc=function(igot) 
  {
    if (igot<1) return(".")
    if (igot>maxnrow) return(".")
    return(paste0(sfp[igot,'v'],"(",sfp[igot,'c'],")"))
  }
  retV=paste0(getvc(igot-2),'_',getvc(igot-1),'_',getvc(igot),'_x_',getvc(igot+1),'_',getvc(igot+2),'_',getvc(igot+3))
  return(retV)
}

getPeriod=function(dailyData,period)
{
  perInfo=NULL
  for (i in 1:(length(period)-1)  ) 
  {
    dailySub=dailyData[period[i]<=dailyData$stamp & dailyData$stamp<=period[i+1], ]
    if (nrow(dailySub)>0)  
    {
      temp=data.frame(p=period[i], i=range(dailySub$hsi)[1],x=range(dailySub$hsi)[2])
      perInfo=rbind(perInfo, temp)
    }
  }
  return(perInfo)
}

normalFun=function(x, l, h) round((x -l)/(h-l) , 2)

getRecentBound=function()
{
  fileName=paste0('/kim/data/Data',Sys.Date())
  if (file.exists(fileName)) load(file=fileName) else return(paste0(fileName,' Not Found'))
  dailyData=dailyData[dailyData$date==Sys.Date(), ]
  if (nrow(dailyData)<10) return('')
  period=c(0930,1000,1030,1100,1130,1200,1330,1400,1430,1500,1530,1600,1630)
  perInfo=getPeriod(dailyData, period)
  perInfo=perInfo[order(perInfo[,1], decreasing =TRUE),]
  perInfo$diff=perInfo$x-perInfo$i
  
  perInfo$d1=NA
  perInfo$d2=NA
  
  perInfo$w1=NA
  perInfo$w2=NA
  
  perInfo$m1=NA
  perInfo$m2=NA
  
  if (nrow(perInfo)>=2)
  {
    for (i in 1:(nrow(perInfo)-1) )
    {

      l=perInfo[i+1, 2]
      h=perInfo[i+1, 3]

      perInfo[i, 'd1']  = normalFun(perInfo[i, 2], l, h)
      perInfo[i, 'd2']  = normalFun(perInfo[i, 3], l, h)
      
      perInfo[i, 'w1']  = normalFun(perInfo[i, 2], lastWeekRange[1] , lastWeekRange[2])
      perInfo[i, 'w2']  = normalFun(perInfo[i, 3], lastWeekRange[1] , lastWeekRange[2])
      
      perInfo[i, 'm1']  = normalFun(perInfo[i, 2], lastMonthRange[1], lastMonthRange[2])
      perInfo[i, 'm2']  = normalFun(perInfo[i, 3], lastMonthRange[1], lastMonthRange[2]) 

    }
  }
  retV=''

  for (k in 1:nrow(perInfo))  retV=paste(retV, "\n\n", perInfo[k,1],' ',perInfo[k,2],' ',perInfo[k,3],' ',perInfo[k,'diff'],';',perInfo[k,'m1'],' ',perInfo[k,'m2'],';',perInfo[k,'w1'],' ',perInfo[k,'w2'],';',perInfo[k,'d1'],' ',perInfo[k,'d2']  )
  #for (k in 1:nrow(perInfo))  retV=paste(retV, "\n\n", perInfo[k,1],' ',perInfo[k,2],' ',perInfo[k,3],' ',perInfo[k,'diff']  )

    return(retV)
}




