

require(DBI)
require("RSQLite")

#xmlData <- xmlParse("/kim/conf.xml")
#confData <- xmlToList(xmlData)
#SQLITE_FILE=confData[['SQLITE_FILE']]

SQLITE_FILE="D:\\SQLITE\\nammik.sqlite"
  
conn = dbConnect(RSQLite::SQLite(), SQLITE_FILE)
#
#install.packages('RMariaDB')

gb_jdbc_cursor_counter<<-0
dbGetQuery=function(conn, sql)
{
  if (gb_jdbc_cursor_counter>20) {print('resetjdbc');resetjdbc();}
  gb_jdbc_cursor_counter <<- gb_jdbc_cursor_counter+1
  RSQLite::dbGetQuery(conn, sql)
}




resetjdbc=function(second=0)
{
  

  gb_jdbc_cursor_counter <<- 0

  conn <<- RSQLite::dbConnect(RSQLite::SQLite(), SQLITE_FILE)
}

sqlUpdateQuery=function(conn, sql)
{
  return(dbSendStatement(conn, sql))
}



insertDataFrame_sqlite=function(myconn, dat, dataType, tablename)
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
    dbSendStatement(myconn, sql)
  }
}


# list table
# dbListTables(conn)

runSQL=function(sql) { return(dbGetQuery(conn, sql)) }