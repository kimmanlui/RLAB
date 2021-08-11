
main_ENV.R=Sys.time()

require(XML)
xmlData <- xmlParse("/kim/conf.xml")
confData <- xmlToList(xmlData)

rootDirR="/kim/gitdir/RLAB/Price/"
source('/kim/gitdir/RLAB/common/From_util.R')
source('/kim/gitdir/RLAB/common/JDBC_SQLITE.R')

source( paste0(rootDirR, "et_LIB.R") )
source( paste0(rootDirR, "dailyData.R") )
source( paste0(rootDirR, "dailyData_LIB.R") )

batchToStamp=function(x)  return ( (x%/%60+9)*100+(x%%60) )

displayQueue=function(x)
{
  fileConn<-file("../../content.txt")
  writeLines(as.character(x), fileConn)
  close(fileConn)
}

