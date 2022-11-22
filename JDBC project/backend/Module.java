package Backend;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class Module {
	Connection con = null;
	PreparedStatement pst = null;
	ResultSet rs = null;
	Statement st = null;

	public static Connection Connect () {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?verifyServerCertificate=false&useSSL=true","root","");
			System.out.println("Connected");
			return con;
		}catch (Exception ex) { //exception handling (if any)
			System.out.println("Cannot connect");
			ex.printStackTrace();
			return null;
		}
	}

}
