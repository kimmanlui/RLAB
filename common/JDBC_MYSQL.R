

require(DBI)
require("RJDBC")

xmlData <- xmlParse("/kim/conf.xml")
confData <- xmlToList(xmlData)

jarFile=confData[['MYSQL_JAR']]

jdbcDriver <- JDBC("com.mysql.jdbc.Driver",
            jarFile,
            identifier.quote="`")



dblink=list( confData[['MYSQL_URL']] , confData[['MYSQL_LOGIN']], confData[['MYSQL_PASSWORD']])  #PROD

gb_jdbc_cursor_counter<<-0
#
#install.packages('RMariaDB')
dbGetQuery=function(conn, sql)
{
  if (gb_jdbc_cursor_counter>30) resetjdbc()
  gb_jdbc_cursor_counter <<- gb_jdbc_cursor_counter+1
  RJDBC::dbGetQuery(conn, sql)
}


conn = RJDBC::dbConnect(jdbcDriver, 
                 dblink[[1]], 
                 dblink[[2]], 
                 dblink[[3]])

resetjdbc=function(second=0)
{
  
  tryCatch(dbDisconnect(conn), error=function(e) print("timeout conn"))
  Sys.sleep(second)
  gb_jdbc_cursor_counter <<- 0
  conn <<- RJDBC::dbConnect(jdbcDriver, 
                     paste0("jdbc:oracle:thin:@//",dblink[[1]]), 
                     dblink[[2]], 
                     dblink[[3]])
}




runSQL=function(sql) { return(dbGetQuery(conn, sql)) }