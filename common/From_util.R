


getStamp=function() format(Sys.time(),"%H%M")
getBatch=function() batch.numeric(as.numeric(getStamp()))

insertDataFrame=function(myconn, dat, dataType, tablename)
{
  checkIf(class(dat)!="data.frame", "error: dat should be data.frame"  )
  checkIf(  ncol(dat)!=length(dataType) , "error: dat should be data.frame"  )
  
  for (k in 1: nrow(dat))
  {
    #k=1
    sql=paste0("insert into ",tablename," values (")
    for (i in 1: length(dataType))
    {  # i =1
      if (dataType[i]=="c") cell=paste0("'",dat[k,i],"'") else cell=paste0("",dat[k,i],"")
      if (i!=length(dataType)) sql=paste0(sql, cell, " , ") else sql=paste0(sql, cell, ")")
    }  
    sqlUpdateQuery(myconn, sql)
  }
}

getSSEC=function() 
{
  link="http://hq.sinajs.cn/list=sh000001"
  tbl=read.table(link, header=FALSE, sep=",",encoding="UTF-8")
  txt=toString(tbl[1,1])
  txt=strsplit(txt,",")[[1]]
  names(sample)
  tradeTime=as.POSIXct(paste(txt[31], txt[32]))
  last=as.numeric(txt[4])
  open=as.numeric(txt[2])
  high=as.numeric(txt[5])
  low=as.numeric(txt[6])
  vol=as.numeric(txt[9])/1000
  yesday=as.numeric(txt[3])
  chgV=last-yesday
  chgPC=(chgV/yesday)*100
  retV=data.frame(tradeTime,last,chgV, chgPC, open, high, low,vol)
  names(retV)=c("Trade Time","Last","Change","% Change","Open","High","Low","Volume")
  return(retV)
}

batch.numeric=function(x) { k=(x/100); return (round(as.integer(k)*60 + (k-as.integer(k))*100 -9*60)) }

batchToStamp=function(x)  return ( (x%/%60+9)*100+(x%%60) )

substrRight= function(x, n)
{
  substr(x, nchar(x)-n+1, nchar(x))
}

checkIf=function(cond, messageText)
{
  # same as if then but improve readability
  if (cond) stop(messageText)
}


wakeUp=function(fromSec=40, toSec=45)
{
  sec=as.numeric(format(Sys.time(),"%S"))
  if (sec<=fromSec)
  { 
    Sys.sleep(fromSec-sec)
  } else if (sec>=toSec)
  {
    nextWait=fromSec+(60-sec)
    Sys.sleep(nextWait)
  }  
}


### jdbc.R

sqlUpdateQuery=function(conn, sql)
{
  return(dbSendUpdate(conn, sql))
}

