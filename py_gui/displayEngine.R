rm(list = ls(all = TRUE)) 

if (!exists("main_ENV.R")) source("main_ENV.R")



startTime =0921
startLunch=1202
endLunch  =1259
endTime   =1602

stamp=as.character(format(Sys.time(),"%H%M" ))
istamp=as.numeric(stamp)
firsttime=1

print("before while")
while(1==1)
{
  
  dayOfWeek=weekdays(Sys.Date())
  dweek=!(dayOfWeek=='Sunday' || dayOfWeek=='Saturday')
   
  if (dweek)
  {
    while (firsttime==1 || startTime<=istamp && istamp<endTime)
    {
      if ( firsttime==1 || (startTime<=istamp && istamp<=startLunch) ||  (endLunch<=istamp && istamp<endTime) )
      {
          
          source("main.R")
        
          #batch=getBatch()
          #vl.org=NULL 

          #vl.org=tryCatch({
          #  getPrice()
          #}, warning = function(w) {  NULL
          #}, error = function(e)   {  print(paste(Sys.time()," Error : calling getprice")) 
          #})

          #hsi=round(as.numeric(vl.org[3])) %% 1000
          #text=paste0(hsi, " ", batchToStamp(vl.org[2]))
          #print(text)
          #displayQueue(text)

          firsttime=firsttime+1
      } 
      if (istamp >= 1700 && firsttime!=1)
      {
        Sys.sleep(10);
        quit() 
      }
         
      istamp=as.numeric(as.character(format(Sys.time(),"%H%M" )))
      oldsec=as.numeric(as.character(format(Sys.time(),"%S" )))
      if (oldsec==0)
      {
          Sys.sleep(1)
          oldsec=as.numeric(as.character(format(Sys.time(),"%S" )))
      }
      newsec=as.numeric(as.character(format(Sys.time(),"%S" )))
          
      print('DisplayEngine ..')
      while( newsec>=oldsec)
      {
         Sys.sleep(1)
         newsec=as.numeric(as.character(format(Sys.time(),"%S" )))
      }
      
    }
  } else
  {
    quit()
  }
}
