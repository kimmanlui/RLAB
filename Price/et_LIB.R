

 
library(RCurl)
library(XML)
library(rvest)
getStamp=function() format(Sys.time(),"%H%M")
getBatch=function() batch.numeric(as.numeric(getStamp()))
substrRight= function(x, n)
{
  substr(x, nchar(x)-n+1, nchar(x))
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
getETQuote = function() {
  date=Sys.Date()
  batch=getBatch()
  base_url <- "http://www.etnet.com.hk/www/eng/futures/index.php"
  #base_url <- "http://futures.etnet.com.cn/www/eng/futures/index.php"
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


#jdbcURL="jdbc:mysql://99.myftp.org:3306/nammik"



#print(paste(vl,ssec,as.character(format(Sys.time(),"%H%M:%S" ))))

#jdbcURL="jdbc:mysql://localhost:3306/nammik"
#myConn=jdbcConnect()
#insertDataFrame(myConn, vl.org, c("c", "n", "c", rep("n",8),"c","n" ), "et" )
#close(myConn)

