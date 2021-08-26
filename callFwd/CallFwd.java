
import java.io.*;
import java.io.FileInputStream;
import java.io.DataInputStream;
import java.io.InputStreamReader;
import java.io.FileNotFoundException;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Calendar;
import jtcpfwd.ForwarderThread;
import jtcpfwd.destination.Destination;
import jtcpfwd.forwarder.Forwarder;
import jtcpfwd.listener.Listener;
import jtcpfwd.util.StreamForwarder;


public class CallFwd{

    public String[] SUPPORTED_DESTINATIONS = {
            "Simple", "RoundRobin", "AddressStream"
    };



    public String[] SUPPORTED_LISTENERS = {
            "Simple", "Reverse", "Forwarder", "PeerFilter",
            "SSL", "Coupler", // end of lite
            "Combine", "UDPTunnel", "UDPTunnelPTP", "UDP",
            "SOCKS", "SOCKSProxy", "Restartable",
            "File", "Clipboard", "Screen", "HTTPTunnel", "Internal",
            "Watchdog",
            "Knock" // last one!
    };

    public String[] SUPPORTED_FORWARDERS = {
            "Simple", "Reverse", "ListenOnce", "Retry", "Mux",
            "DeMux", "PeerDeMux", "RoundRobin", "SSL", // end of lite
            "Split", "Combine", "UDPTunnel", "UDPTunnelPTP", "UDP",
            "SOCKS", "Flaky", "Restartable", "Blackhole",
            "File", "Clipboard", "Screen", "HTTPTunnel", "Internal",
            "Watchdog", "Console", "StdInOut", "Knock",
            "Filter" // last one!
    };
	
	public String[] getPara(String fileabspath) {
        String[] arr= null;
        List<String> itemsSchool = new ArrayList<String>();

        try 
        { 
            FileInputStream fstream_school = new FileInputStream(fileabspath); 
            DataInputStream data_input = new DataInputStream(fstream_school); 
            BufferedReader buffer = new BufferedReader(new InputStreamReader(data_input)); 
            String str_line; 

            while ((str_line = buffer.readLine()) != null) 
            { 
                str_line = str_line.trim(); 
                if ((str_line.length()!=0))  
                { 
                   itemsSchool.add(str_line);
                } 
            }

            arr = (String[])itemsSchool.toArray(new String[itemsSchool.size()]);
        } catch(Exception e) 
		{
	      	e.printStackTrace();	
		}
		return(arr); 
	}
	
	public void printPara(String[] para)
	{
		for (int i=0; i<para.length; i++)
		{
			System.out.println(i+": "+para[i]); 
		}
	}
	
	public int compPara(String[] paraA , String[] paraB)
	{
		if (paraA.length!=paraB.length) return -1; 
		for (int i=0; i<paraA.length; i++)
		{
			if (!paraA[i].equals(paraB[i])) return -1;  
		}
		return 1; 
	}
	
	public void copyFileUsingStream(String sourceFile, String destFile) throws IOException {
		File source = new File(sourceFile);
		File dest = new File(destFile);
        InputStream is = null;
        OutputStream os = null;
        try {
            is = new FileInputStream(source);
            os = new FileOutputStream(dest);
            byte[] buffer = new byte[1024];
            int length;
            while ((length = is.read(buffer)) > 0) {
               os.write(buffer, 0, length);
            }
        } finally {
            is.close();
            os.close();
        }
    }

  public  ForwarderThread[] start(String[] args) throws Exception {
        ForwarderThread[] result;
        if (args.length == 1 && args[0].startsWith("@")) {
            List/* <ForwarderThread> */threads = new ArrayList();
            BufferedReader br = new BufferedReader(new FileReader(args[0].substring(1)));
            String line;
            while ((line = br.readLine()) != null) {
                line = line.trim();
                if (line.length() == 0 || line.startsWith("#"))
                    continue;
                String[] parts = line.split("[ \t]+");
                if (parts.length == 2) {
                    ForwarderThread t = new ForwarderThread(parts[0], parts[1]);
                    threads.add(t);
                    t.start();
                    for (int k=0; k<10; k++)
                    {
                       System.out.println("sleep"); 
                       Thread.sleep(2000);
                    }
                    t.stop(); 
                    
                } else {
                    throw new IOException("Invalid line in config file: " + line);
                }
            }
            result = (ForwarderThread[]) threads.toArray(new ForwarderThread[threads.size()]);
        } else if (args.length == 3 && args[0].equals("-listdestination")) {
            int count = Integer.parseInt(args[1]);
            Destination dest = Destination.lookupDestination(args[2]);
            for (int i = 0; i < count; i++) {
                System.out.println(dest.getNextDestination());
            }
            dest.dispose();
            return new ForwarderThread[0];
        } else if (args.length == 0 || args.length % 2 != 0) {
            System.out.println("Usage: java -jar jTCPfwd.jar @<configfile>");
            System.out.println("       java -jar jTCPfwd.jar <listener> <forwarder> [<lis2> <forw2> [...]]]");
            System.out.println("       java -jar jTCPfwd.jar -listdestination <count> <destination>");
            System.out.println();
            System.out.println("<configfile> is a file which contains one proxy rule (<listener> <forwarder>)");
            System.out.println("on each line.");
            System.out.println("Lines starting with # are ignored as comments. Alternatively, proxy rules can");
            System.out.println("be given on the command line.");
            System.out.println();
            System.out.println("Both <listener> and <forwarder> can start with  '<type>@', giving the type of");
            System.out.println("the listener or forwarder. Types are case sensitive.");
            System.out.println();
            System.out.println("-listdestination prints the first <count> results produced by <destination>.");
            System.out.println();
            System.out.println("Destinations can be given as <host>:<port>, or in more sophisticated formats:");
            
            System.out.println();
            System.out.println("Supported listener types:");
           
            System.out.println();
            System.out.println("Supported forwarder types:");
            
            return new ForwarderThread[0];
        } else {
            result = new ForwarderThread[args.length / 2];
            for (int i = 0; i < args.length; i += 2) {
                System.out.println(i);
                result[i / 2] = new ForwarderThread(args[i], args[i + 1]);
                result[i / 2].start();

                
            }
        }
        System.out.println("All forwarders started.");
        return result;
    }
	
  public static void main(String[] args)
  {
    System.out.println("Number of input parameters :"+args.length);
	CallFwd callfwd = new CallFwd(); 
	String confMaster=args[0];
	System.out.println("confMaster: "+confMaster);
	String[] paraFile=callfwd.getPara(confMaster);
	
	String workParaFile =paraFile[0]; 
	String sleepParaFile=paraFile[1]; 
	String recoverParaFile =paraFile[2]; 
	int sleepH=Integer.parseInt(paraFile[3]); 
	int sleepM=Integer.parseInt(paraFile[4]); 
	int recoverH=Integer.parseInt(paraFile[5]);
	int recoverM=Integer.parseInt(paraFile[6]);
	
	System.out.println("workParaFile    "+workParaFile);
	System.out.println("sleepParaFile   "+sleepParaFile);
	System.out.println("recoverParaFile "+recoverParaFile);	
	System.out.println("Sleep   "+sleepH+":"+sleepM);
	System.out.println("Recover "+recoverH+":"+recoverM);
	
	String[] currpara=null; 
	String[] lastpara=null; 
	String[] sleeppara=null;
	String[] recoverpara=null; 
	
	currpara=callfwd.getPara(workParaFile);
	lastpara=callfwd.getPara(workParaFile);
	
	callfwd.printPara(currpara);
	
    int RESTART_CODE=111;
    String VERSION = "0.5";

    /**
     * Entry point of this application.
     */


 

    //directTo='exac5-scan.hk1.ocm.s7480887.oraclecloudatcustomer.com:1521'
    //directTo='localhost:80'
    //String[] args=['8085', directTo]
    //System.out.println("JTCPfwd "+VERSION);
    System.out.println();
    ForwarderThread[] result=null; 
	
	
	try {
        result=callfwd.start(currpara);



        for (int k=0; k<1000000;k++)
        {
	
            Thread.sleep(60000);

		    currpara=callfwd.getPara(workParaFile);
		    if (callfwd.compPara(currpara, lastpara)==-1) 
		    {
			    System.out.println("Paramater Changed: Restart");
			    System.exit(RESTART_CODE);
		    }
		

            Calendar now = Calendar.getInstance();
		    int hour = now.get(Calendar.HOUR_OF_DAY);
            int minute = now.get(Calendar.MINUTE);
            System.out.println("time "+hour+":"+minute);
            if (sleepH==hour && sleepM<=minute && (minute<=sleepM+5) ) 
		    {
				sleeppara=callfwd.getPara(sleepParaFile);
				if (callfwd.compPara(currpara, sleeppara)==1) 
				{
					System.out.println("System Already Slept");
				} else
				{
			        callfwd.copyFileUsingStream(workParaFile, recoverParaFile);
			        callfwd.copyFileUsingStream(sleepParaFile, workParaFile);
			        System.out.println("System gonna Sleeping");
				}
		    }
		    if (recoverH==hour && recoverM<=minute && minute<=recoverM+5 ) 
		    {
				System.out.print("recover");
				recoverpara=callfwd.getPara(recoverParaFile);
				if (callfwd.compPara(currpara, recoverpara)==1) 
				{
					System.out.println("System Already Recovered");
				} else
				{
			      callfwd.copyFileUsingStream(recoverParaFile, workParaFile);
			      System.out.println("System gonna recovering");
				}
		    }


            System.out.print(".");
        }
	
	}
    catch(Exception e) {
       e.printStackTrace();
    }

	System.out.print("-END-");
    System.exit(RESTART_CODE);
  }
}