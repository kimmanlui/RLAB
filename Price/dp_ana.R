
setR=NULL
totals=nrow(s)
for (i in totals: (totals-600) )
{
  sDate=index(s[i,])
  oneR=dp.ana(sDate= sDate, data=s, n=5)
  setR=rbind(setR, oneR)
}

(sum(setR$pcdp>1 & setR$cdp>1)) / sum(setR$pcdp>1 )
(sum(setR$pcdp>1 & setR$hdp>1)) / sum(setR$pcdp>1 )

(sum(setR$phdp>1 & setR$cdp>1)) / sum(setR$phdp>1 )

aV=0.80
cond= setR$phdp>1 & setR$pcdp>=aV & setR$pcdp<setR$podp
(sum( cond
     & setR$hdp>1)) / sum(cond)
sum(cond)
