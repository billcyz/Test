
//This program is find your exact LAN(Local Machine on which your are       //runing this program) IP Address 
	import java.net.InetAddress;
	import java.net.NetworkInterface;
	import java.net.SocketException;
	import java.util.Enumeration;

public class GetIP
{
	public static void main(String gks[]) throws SocketException{
	    Enumeration e = NetworkInterface.getNetworkInterfaces();
	    int ctr=0;
	    while(e.hasMoreElements())
	    {
	        NetworkInterface n = (NetworkInterface) e.nextElement();
	        Enumeration ee = n.getInetAddresses();
	        while (ee.hasMoreElements() && ctr<3)
	        {       ctr++;
	            if(ctr==3)
	                break;
	                InetAddress i = (InetAddress) ee.nextElement();
	                    if(ctr==2)
	                         System.out.println(i.getHostAddress());

	        }
	    }
	}
}
