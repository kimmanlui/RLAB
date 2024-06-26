# RLAB Provides a set of useful functions
# VERSION 1.0

getPrice=function(sDate=NULL)
{
  if (is.null(sDate))
  {
    sql="select * from et order by date desc, batch desc  LIMIT 1 "
  } else
  {
    sql=paste0("select * from et where date='",sDate,"' order by date desc, batch desc ")
    #print(sql)
  }
  retV=dbGetQuery(conn,sql)
  return(retV)
}


is.date <- function(x) inherits(x, 'Date')

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
 

getDataRange_old=function(reqFun, data=s, myDate=Sys.Date() ) 
{
  if (is.date(index(data))) dateDex=index(data)
  else if ("date" %in% colnames(data) && is.date(data$date)) dateDex=data$date
  tempData=(data[ dateDex %in% reqFun(myDate),])[,c(2,3)]
  if (nrow(tempData)==0) return(NULL)
  retV=round(range( tempData ),0)
  return(retV)
}  


getDataRange=function(reqFun, data=s, myDate=Sys.Date() , useColumn='x') 
{
  if (is.date(index(data))) dateDex=index(data)
  else if ("date" %in% colnames(data) && is.date(data$date)) dateDex=data$date
  tempData=(data[ dateDex %in% reqFun(myDate),])[,c(2,3)]
  if (nrow(tempData)==0) return(NULL)
  
  if (useColumn!='x')
  {
    for ( i in nrow(tempData) )
    {
      if (is.na(tempData[i,1]))
      {
        tmpDate= index(tempData[i,1])
        tmp    = getPrice(sDate=tmpDate)
        tmpRg  = range(tmp[,useColumn])
        tempData[i,1] = tmpRg[1]
        tempData[i,2] = tmpRg[2]
      }
    }
  }
  
  
  retV=round(range( as.numeric(tempData) ),0)

  return(retV)
}

normalBody=function(  oV, hV, lV, cV  , datRg, colNameSuffix)
{
  rgdpT=datRg$bodyRg[2]-datRg$bodyRg[1]
  oT=normalFun(as.numeric(oV),datRg$bodyRg[1], datRg$bodyRg[2])
  hT=normalFun(as.numeric(hV),datRg$bodyRg[1], datRg$bodyRg[2])
  lT=normalFun(as.numeric(lV),datRg$bodyRg[1], datRg$bodyRg[2])
  cT=normalFun(as.numeric(cV),datRg$bodyRg[1], datRg$bodyRg[2])
  t.df=data.frame(rg=rgdpT, oT=oT, hT=hT, lT=lT, cT=cT)
  colnames(t.df)=paste0( c('rg','o','h','l','c') , colNamePrefix)
  return(t.df)
}

dp.ana=function(sDate, data, n=5)
{
  dat=getLastTrade(sDate,data=data, n=n)
  today=index(dat$cur[1])
  yesterday=index(dat$body[n])
  
  datRg=getLastTradeRange(sDate,data=data, n=n)
  
  rgdp=datRg$bodyRg[2]-datRg$bodyRg[1]
  odp=normalFun(as.numeric(dat$cur[,1]),datRg$bodyRg[1], datRg$bodyRg[2])
  hdp=normalFun(as.numeric(dat$cur[,2]),datRg$bodyRg[1], datRg$bodyRg[2])
  ldp=normalFun(as.numeric(dat$cur[,3]),datRg$bodyRg[1], datRg$bodyRg[2])
  cdp=normalFun(as.numeric(dat$cur[,4]),datRg$bodyRg[1], datRg$bodyRg[2])
  
  pdat=getLastTrade(yesterday,data=data, n=n)
  pdatRg=getLastTradeRange(yesterday,data=data, n=n)
  prgdp=diff(pdatRg$bodyRg)
  podp=normalFun(as.numeric(pdat$cur[,1]),pdatRg$bodyRg[1], pdatRg$bodyRg[2])
  phdp=normalFun(as.numeric(pdat$cur[,2]),pdatRg$bodyRg[1], pdatRg$bodyRg[2])
  pldp=normalFun(as.numeric(pdat$cur[,3]),pdatRg$bodyRg[1], pdatRg$bodyRg[2])
  pcdp=normalFun(as.numeric(pdat$cur[,4]),pdatRg$bodyRg[1], pdatRg$bodyRg[2])
  
  fdat=getLastTrade(sDate,data=data, n=(n-1))
  fdatRg=getLastTradeRange(sDate,data=data, n=(n-1))
  oF=normalFun(as.numeric(dat$cur[,1]),datRg$allRg[1], datRg$allRg[2])
  cF=normalFun(as.numeric(dat$cur[,4]),datRg$allRg[1], datRg$allRg[2])
  
  retV=data.frame(prgdp=round(prgdp),podp=podp, phdp=phdp,pldp=pldp,pcdp=pcdp,
                  rgdp=round(rgdp),odp=odp, hdp=hdp,ldp=ldp,cdp=cdp,
                  oF=oF,cF=cF) 
  row.names(retV)=today
  return(retV)
}

getLastTradeRange=function(sDate, data, n=5)
{
  myD=getLastTrade(sDate,data=data, n=n)
  bodyRg=range(myD[[1]][,1:4])
  curRg=range(myD[[2]][,1:4])
  allRg=range(myD[[3]][,1:4])
  return(list( bodyRg=bodyRg, curRg=curRg, allRg=allRg))
}

getLastTrade=function(sDate, data, n=5)
{
  if (!("xts" %in% class(data))) stop("Wrong data type, mush xts")
  currTradeDate=getTradeDate(sDate, data)
  dx=which(index(data)==currTradeDate)
  bodyDat=data[(dx-1):(dx-n),]
  curDat=data[dx,]
  allDat=data[(dx):(dx-n),]
  return(list(body=bodyDat,cur=curDat,all=allDat))
}

getTradeDate=function(sDate, data)
{
  for (i in 0:10)
  {
    tradeDate=as.Date(sDate)-i
    if ( tradeDate %in%  index(data)) return (tradeDate)
  }
  return(0)
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


getRecentBound_for_last=function(x)
{
  wkLast=normalFun( x , lastWeekRange[1]  , lastWeekRange[2])
  mtLast=normalFun( x , lastMonthRange[1] , lastMonthRange[2])
  return(c(mtLast, wkLast))
}

getRecentBound_for_this=function(x)
{
  wkThis=normalFun( x , thisWeekRange[1]  , thisWeekRange[2])
  mtThis=normalFun( x , thisMonthRange[1] , thisMonthRange[2])
  return(c(mtThis, wkThis))
}


getRecentBound_for_thislast=function(x)
{
  
  wk=normalFun( x , min(thisWeekRange[1],lastWeekRange[1])  , max(thisWeekRange[2],lastWeekRange[2]) )
  mt=normalFun( x , min(thisMonthRange[1],lastMonthRange[1])  , max(thisMonthRange[2],lastMonthRange[2]) )
  return(c(mt, wk))
}


getRecentBound=function()
{
  #fileName=paste0('/kim/data/Data',Sys.Date())
  #if (file.exists(fileName)) load(file=fileName) else return(paste0(fileName,' Not Found'))
 
  
  sql=paste0("select * from et where date='",Sys.Date(),"'")
  dailyData=dbGetQuery(conn, sql)

  
  dailyData=dailyData[dailyData$date==Sys.Date(), ]
  if (nrow(dailyData)<10) return('')
  period=c(0930,1000,1030,1100,1130,1200,1330,1400,1430,1500,1530,1600,1630)
  dailyData$stamp = batchToStamp(dailyData$batch)
  
  perInfo=getPeriod(dailyData, period)
  
  perInfo=perInfo[order(perInfo[,1], decreasing =TRUE),]
  perInfo$x   = as.numeric(as.character(perInfo$x))
  perInfo$i   = as.numeric(as.character(perInfo$i))
  perInfo$diff= perInfo$x - perInfo$i
  
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


#getRecentBound()

