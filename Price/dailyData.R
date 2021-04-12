
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

url="https://raw.githubusercontent.com/kimmanlui/RLAB/main/Price/dailyData_LIB.R"
source(url)

thisWeekRange =getDataRange(getThisWeek)
lastWeekRange =getDataRange(getLastWeek)
thisMonthRange=getDataRange(getThisMonth)
lastMonthRange=getDataRange(getLastMonth)

thisWeekRange
lastWeekRange
thisMonthRange
lastMonthRange