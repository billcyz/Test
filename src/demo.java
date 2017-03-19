
import java.io.IOException;
import com.ericsson.otp.erlang.OtpErlangObject;  
import com.ericsson.otp.erlang.OtpErlangPid;  
import com.ericsson.otp.erlang.OtpErlangTuple;  
import com.ericsson.otp.erlang.OtpMbox;  
import com.ericsson.otp.erlang.OtpNode;  
  
public class demo
{
	//static String server = "server";
	
    public static void main(String[] args) throws Exception 
    {  
  
        String cookie = "123456";  
        //OtpNode node = new OtpNode("java_node@127.0.0.1", cookie);  
        OtpNode node = new OtpNode("java_node", cookie);
        OtpMbox mbox = node.createMbox();  
        mbox.registerName("java_node_name");  
  
        System.out.println("java node start");  
  
        OtpErlangObject o;  
        OtpErlangTuple msg;  
        OtpErlangPid from;
  
        while (true) {  
            try {  
                o = mbox.receive();  
                System.out.println("recv:" + o);  
                if (o instanceof OtpErlangTuple) {  
                    msg = (OtpErlangTuple) o;  
                    from = (OtpErlangPid) (msg.elementAt(0));  
                    mbox.send(from, msg.elementAt(1)); // 原消息返回  
                }  
            } catch (Exception e) {  
                System.out.println("" + e);  
            }  
        }  
    }  
}  