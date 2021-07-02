
insertMongo=function(whereColumn, whereValue, insertColumn, insertValue, mg )
{  
  monString='{ "whereColumn": "whereValue", "insertColumn": "insertValue" } '
  monString=gsub('whereColumn', whereColumn, monString)
  monString=gsub('whereValue', whereValue, monString)
  monString=gsub('insertColumn', insertColumn, monString)
  monString=gsub('insertValue', insertValue, monString)
  retV=mg$insert(monString)
}

findMongo=function(whereColumn='TEST', whereValue=TRUE, mg)
{
  # Eg. updateMongoDF( df[1,'COL1', drop=FALSE], df[1,c('COL2','COL3'), drop=FALSE], mg)
  where.df=data.frame(X=whereValue)
  colnames(where.df)=whereColumn
  wst=toJSON(where.df[1,,drop=FALSE])
  monQ=substr(wst,2,(nchar(wst)-1))
  #print(monQ)
  #monU=paste0( '{"$set":  ' , substr(jst,2,(nchar(jst)-1)) , "}")
  #print(monU)
  retV=mg$find(query=monQ)
  return(retV)
}

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


findMongoDF=function(where.df, mg)
{
  # Eg. updateMongoDF( df[1,'COL1', drop=FALSE], df[1,c('COL2','COL3'), drop=FALSE], mg)
  wst=toJSON(where.df[1,,drop=FALSE])
  monQ=substr(wst,2,(nchar(wst)-1))
  #print(monQ)
  monU=paste0( '{"$set":  ' , substr(jst,2,(nchar(jst)-1)) , "}")
  #print(monU)
  retV=mg$find(query=monQ)
  return(retV)
}
