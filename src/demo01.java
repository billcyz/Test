
import com.ericsson.otp.erlang.OtpErlangObject;
import com.ericsson.otp.erlang.OtpErlangPid;
import com.ericsson.otp.erlang.OtpErlangTuple;
import com.ericsson.otp.erlang.OtpMbox;
import com.ericsson.otp.erlang.OtpNode;

public class demo01
{
	public static int minFunction(int n1, int n2)
	{
		int min;
		if (n1 > n2)
			min = n2;
		else
			min = 1;
		return min;
	}
	
	public static void main(String[] args)
	{
		System.out.println("hello");
		OtpNode comp_01 = new OtpNode("comp_01@");
	}
}
