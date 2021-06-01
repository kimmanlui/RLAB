

import stock.Timer;
import stock.ReadXML; 
import java.io.IOException;
import java.io.BufferedWriter;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream; 
import java.io.InputStream;
import java.io.FileInputStream; 
import java.io.FileOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintStream;

public class Scheduler {
   
   
   private Timer TM = new Timer();
   
   private int[] taskTime=null; 
   private String[] taskDay=null; 
   private String[] task=null; 
   private int osType = 0; 
   
   public String TEMPDIR=""; 
   
   public Scheduler()
   {
      String OS = System.getProperty("os.name").toLowerCase();
      if (OS.indexOf("win") >= 0)  osType=1;
      else osType=2; 
	  
	  TEMPDIR=new ReadXML().getTagValue("config.xml", "dir");
	  System.out.println("TEMPDIR: "+TEMPDIR);
   }
   
   public int loadTask(String taskFile)
   {
      //System.out.println("The task file is "+taskFile); 
      int numTask=0;
      try { 
         File file = new File(taskFile); 
         String sCurrentLine="";
         FileReader fr = new FileReader(file.getAbsoluteFile());
         BufferedReader br = new BufferedReader(fr);
         while ((sCurrentLine = br.readLine()) != null) {
            String sLowerCurrentLine=sCurrentLine.toLowerCase();
            if (sLowerCurrentLine.indexOf("at")==0 && sLowerCurrentLine.indexOf("/every")>=0)
            {
               numTask=numTask+1; 
              //System.out.println(sCurrentLine);
            }
         }
         br.close(); 
      } 
      catch (IOException e) {
         e.printStackTrace();
      }
   
      if (numTask==0) 
         return numTask; 
      System.out.println("There are "+numTask+" in "+taskFile); 
   
      taskTime=new int[numTask]; 
      taskDay=new String[numTask]; 
      task=new String[numTask]; 
   
      numTask=0;
      try { 
         File file = new File(taskFile); 
         String sCurrentLine="";
         FileReader fr = new FileReader(file.getAbsoluteFile());
         BufferedReader br = new BufferedReader(fr);
         while ((sCurrentLine = br.readLine()) != null) {
            String sLowerCurrentLine=sCurrentLine.toLowerCase();
            if (sLowerCurrentLine.indexOf("at")==0 && sLowerCurrentLine.indexOf("/every")>=0)
            {
               sCurrentLine=sCurrentLine.trim(); //take out "at"
               int endDex=sCurrentLine.indexOf(" "); 
               String element1=sCurrentLine.substring(0,endDex);  
               sCurrentLine=sCurrentLine.substring(endDex);
            
               sCurrentLine=sCurrentLine.trim(); 
               endDex=sCurrentLine.indexOf(" "); 
               String element2=sCurrentLine.substring(0,endDex);  
               sCurrentLine=sCurrentLine.substring(endDex);
                
               sCurrentLine=sCurrentLine.trim(); 
               endDex=sCurrentLine.indexOf(" "); 
               String element3=sCurrentLine.substring(0,endDex); 
               String element4=sCurrentLine.substring(endDex);
               element4=element4.trim(); 
                
               element2=element2.replace(":", ""); 
               taskTime[numTask]=Integer.parseInt(element2);
                
               element3=element3.toLowerCase();
               String temp=""; 
               if (element3.indexOf("monday")>0)    temp=temp+"1"; 
               if (element3.indexOf("tuesday")>0)   temp=temp+"2"; 
               if (element3.indexOf("wednesday")>0) temp=temp+"3"; 
               if (element3.indexOf("thursday")>0)   temp=temp+"4"; 
               if (element3.indexOf("friday")>0)    temp=temp+"5"; 
               if (element3.indexOf("saturday")>0)  temp=temp+"6"; 
               if (element3.indexOf("sunday")>0)    temp=temp+"7"; 
               if (temp.length()==0) 
               {
                  System.out.println("there might be an error on day of week, please check"); 
                  temp="1234567";                 
               }
               taskDay[numTask]=temp; 
               task[numTask]=element4; 
               numTask=numTask+1;               
            }
         }
         br.close(); 
      } 
      catch (IOException e) {
         e.printStackTrace();
      }
      
      //for (int i=1; i<taskTime.length; i++) 
      //{
      //  System.out.println(taskTime[i]+" "+ taskDay[i]);  
      //}
      //taskTime[0]=120; 
      //taskDay[0]="2345"; 
      //task[0]="C:\\kimman\\StockAnalysis\\app\\httpunit-1.7\\RTupdatenonhsi.bat 8888"; 
      return numTask; 
   }
   
   
   // only for windows
   private String handleBat(String cmd,int internalTaskCode)
   {
   
      //String filename="C:\\kimman\\schedule_temp\\temp"+TM.getDate()+"_"+TM.haveIntTime()+"_"+internalTaskCode+".bat";
      String filename=TEMPDIR+"/temp"+TM.getDate()+"_"+TM.haveIntTime()+"_"+internalTaskCode+".bat";
   
      try { 
         File file = new File(filename); 
      	// if file doesnt exists, then create it
         if (!file.exists()) {
            file.createNewFile();
         }
      
         FileWriter fw = new FileWriter(file.getAbsoluteFile());
         BufferedWriter bw = new BufferedWriter(fw);
         bw.write("call "+cmd);
         bw.newLine();
         bw.write("exit");
         bw.close(); 
      } 
      catch (IOException e) {
         e.printStackTrace();
      }
      return filename; 
       
   }
   
   public void exec(String cmd, int internalTaskCode) 
   {
      int lidx=cmd.lastIndexOf("\\"); 
      String messageCmd=cmd.substring(lidx+1);  
      if (osType==1) //win
      {
         if (cmd.indexOf(".bat")>0) 
         {
            cmd=handleBat(cmd, internalTaskCode);
         }
      
         try
         {
            
            String exeCmd="cmd.exe /C start  "+cmd;
            exeCmd="cmd.exe /C start /min "+cmd;
            System.out.println(exeCmd);
            Process proc =Runtime.getRuntime().exec(exeCmd);
            System.out.println(">>> "+messageCmd);  
         } 
         catch (Exception exp) 
         {
            exp.printStackTrace();
         }
      }
      
      if (osType==2) //mac 
      {
         try
         {
            String exeCmd=cmd;
            Process proc =Runtime.getRuntime().exec(exeCmd);
            System.out.println(">>> "+messageCmd);  
         } 
         catch (Exception exp) 
         {
            exp.printStackTrace();
         }
      }
   }
   

    
   public int doTaskAt(int iTime, String dayOfWeek)
   {
      int numTask=0;
      for (int k=0; k<taskTime.length; k++)
      {
         //System.out.println("k:"+k); 
         //System.out.println("taskTime[k]:"+taskTime[k]);
         //System.out.println( taskDay[k].indexOf(dayOfWeek)); 
         if (iTime==taskTime[k] && taskDay[k].indexOf(dayOfWeek)>=0) 
         {
           //System.out.println(k); 
            exec(task[k], k); 
            numTask=numTask+1; 
         }
      }
      return numTask;
   } 
    
   public void start(String taskFile)
   {
      String batchNum=TM.getBatch();
      int iTime=TM.haveIntTime(); 
      int iTimeLast=0; 
      loadTask(taskFile); 
      //int a=2; 
      while(1==1)
      {
         if (iTimeLast!=iTime) 
         {
            iTimeLast=iTime;
            String dayOfWeek=TM.getDayInWeek(); //1-7
            int numTask=doTaskAt(iTime, dayOfWeek); 
         	//if (numTask==0) System.out.print("\b\b\b\b\b\b\b") ;
         	//  else System.out.print("\n");
            System.out.print(iTime+":"+numTask);
            if (numTask==0) System.out.print("\b\b\b\b\b\b\b") ;
            else System.out.print("\n");
         }
         TM.wait(1000); 
         batchNum=TM.getBatch();
         iTime=TM.haveIntTime(); 
      }
   
   } 

   public static void main(String[] args) {
   
      if (args.length>=2 && (args[0].indexOf("out")>=0 && args[0].indexOf(".txt")>0 || args[0].indexOf("NA")>=0) 
                         && (args[1].indexOf("err")>=0 && args[1].indexOf(".txt")>0 || args[1].indexOf("NA")>=0))      
      {
         if ( !(args[0].indexOf("NA")>=0 || args[1].indexOf("NA")>=0) )
         {
            try {
               String outFile=args[0];
               String errFile=args[1];
               System.out.println("Redirect out => "+outFile+" and err =>"+errFile); 
               System.setOut(new PrintStream(new File(outFile)));
               System.setErr(new PrintStream(new File(errFile)));
            
            } 
            catch (Exception e) {
               e.printStackTrace();
               System.exit(1);
            }
         }
        
      } 
      else
      {
         System.out.println("Usuage: Scheduler (*out*.txt|NA) (*err*.txt|NA) taskFile_01 taskFile_02 ... taskFile_10"); 
         System.exit(1);      
      }
      
      System.out.println("Version: 2019.08.25");   
      String taskFile="tmpTask.txt";
      if (args.length>=3)
      {
         try {
            OutputStream out = new FileOutputStream(taskFile);
            byte[] buf = new byte[2048];
            for (int i=2; i<args.length; i++) {
               String file=args[i];
               InputStream in = new FileInputStream(file);
               int b = 0;
               while ( (b = in.read(buf)) >= 0) {
                  out.write(buf, 0, b);
                  out.flush();
               }
            }
            out.close();
         } 
         catch (Exception e)
         {
            System.err.println("Caught Exception: " + e.getMessage());
            System.exit(1);
         }
      }  
      else
      {
         System.out.println("Usuage: Scheduler (*out*.txt|NA) (*err*.txt|NA) taskFile_01 taskFile_02 ... taskFile_10"); 
         System.exit(1);
      }
       
      //String taskFile=args[0]; 
      Scheduler SCH=new Scheduler();
      SCH.start(taskFile); 
   }
   
}
