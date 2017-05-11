
/*
package test;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Properties;

public class ReadPropertiesFile {
	public static void main(String[] args) {
		try {
			File file = new File("test.properties");
			FileInputStream fileInput = new FileInputStream(file);
			Properties properties = new Properties();
			properties.load(fileInput);
			fileInput.close();

			Enumeration enuKeys = properties.keys();
			while (enuKeys.hasMoreElements()) {
				String key = (String) enuKeys.nextElement();
				String value = properties.getProperty(key);
				System.out.println(key + ": " + value);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
} 
*/

/*
package crunchify.com.tutorial;
 
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.Properties;
 
///**
// * @author Crunchify.com
// * 
//
 
public class CrunchifyGetPropertyValues {
	String result = "";
	InputStream inputStream;
 
	public String getPropValues() throws IOException {
 
		try {
			Properties prop = new Properties();
			String propFileName = "config.properties";
 
			inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);
 
			if (inputStream != null) {
				prop.load(inputStream);
			} else {
				throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
			}
 
			Date time = new Date(System.currentTimeMillis());
 
			// get the property value and print it out
			String user = prop.getProperty("user");
			String company1 = prop.getProperty("company1");
			String company2 = prop.getProperty("company2");
			String company3 = prop.getProperty("company3");
 
			result = "Company List = " + company1 + ", " + company2 + ", " + company3;
			System.out.println(result + "\nProgram Ran on " + time + " by user=" + user);
		} catch (Exception e) {
			System.out.println("Exception: " + e);
		} finally {
			inputStream.close();
		}
		return result;
	}
}
*/


import com.ericsson.otp.erlang.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Properties;

public class demo01
{
	public static void main(String[] args)
	{
		if (args[0].equals("register"))
			registerComp();
		else if(args[0].equals("start"))
		{
			// get config file 
			String configFile = args[1];
			FileInputStream fileInput = new FileInputStream(configFile);
		    Properties props = new Properties();
		    props.load(fileInput);
		    fileInput.close();
		    
		    
			startNode();
			
		}
		else
		{
			otherOpts();
		}
	}
	
	// Generate random node
	public randomNode(String ipAddr, String appName)
	{
		// node name: appName_xxxx@ipAddr
		// xxxx is the random 4-digit number
		
	}
	
	// Start Java node
	private static void startNode() throws Exception
	{
		OtpNode myNode = new OtpNode("java_01");
		OtpMbox myMbox = myNode.createMbox("calculator");
		OtpErlangObject myObject;
		OtpErlangTuple myMsg;
		OtpErlangPid from;
		OtpErlangString command;
		Integer counter = 0;
		OtpErlangAtom okAtom = new OtpErlangAtom("ok");
		
		while(counter >= 0) try
		{
			myObject = myMbox.receive();
			myMsg = (OtpErlangTuple) myObject;
			from = (OtpErlangPid) myMsg.elementAt(0);
			
		}
		catch(OtpErlangExit e)
		{
			break;
		}
	}
	
	// Other options
	private static void otherOpts()
	{
		System.out.println("Extra options...\n");
	}
}
