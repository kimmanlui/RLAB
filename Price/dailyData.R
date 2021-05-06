
library(quantmod)
scode='^HSI'
s  =getSymbols(scode, auto.assign = FALSE)
sf =tail(s, 10)
sf =sf[, c(1:4)]
sf =round(sf)
sf =na.omit(sf)
#as.numeric(sf)
sfn=as.numeric(sf)
sfn=round(sfn*2,-2)/2
sfp=data.frame(v=sort(unique(as.numeric(sfn))))
sfp$c=0
for (i in 1:nrow(sfp)) #i=1
{
  sfp[i,'c']=sum(sfn==sfp[i,'v'])
}

source('/kim/gitdir/RLAB/Price/dailyData_LIB.R')
#url="https://raw.githubusercontent.com/kimmanlui/RLAB/main/Price/dailyData_LIB.R"
#source(url)



thislastWeekRange =getDataRange( (function(x) unique(c(getThisWeek() , getLastWeek ())) ) , patchColumnFromDB='hsi') 
thislastMonthRange=getDataRange( (function(x) unique(c(getThisMonth(), getLastMonth())) ) , patchColumnFromDB='hsi') 

thisWeekRange =getDataRange(getThisWeek,  patchColumnFromDB='hsi')
lastWeekRange =getDataRange(getLastWeek,  patchColumnFromDB='hsi')
thisMonthRange=getDataRange(getThisMonth, patchColumnFromDB='hsi')
lastMonthRange=getDataRange(getLastMonth, patchColumnFromDB='hsi')

thisWeekRange
lastWeekRange
thisMonthRange
lastMonthRange