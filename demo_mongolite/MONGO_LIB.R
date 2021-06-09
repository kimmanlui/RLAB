updateMongo=function(whereColumn, whereValue, updateColumn, updateValue, mg)
{
  Qtoken=whereColumn
  Qvalue=whereValue
  Utoken=updateColumn
  UValue=updateValue
  monQ=paste0(' {"',Qtoken,'":"',Qvalue,'"}')
  monU=paste0( '{"$set": {"',Utoken,'":"',UValue,'" }} '  )
  retV=mg$update(query=monQ,  update=monU )
  return(retV)
}
updateMongoDF=function(where.df, update.df, mg)
{
  # Eg. updateMongoDF( df[1,'COL1', drop=FALSE], df[1,c('COL2','COL3'), drop=FALSE], mg)
  wst=toJSON(where.df[1,,drop=FALSE])
  jst=toJSON(update.df[1,,drop=FALSE])
  monQ=substr(wst,2,(nchar(wst)-1))
  #print(monQ)
  monU=paste0( '{"$set":  ' , substr(jst,2,(nchar(jst)-1)) , "}")
  #print(monU)
  retV=mg$update(query=monQ,  update=monU )
  return(retV)
}

